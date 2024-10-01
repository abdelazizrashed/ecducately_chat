import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:educately_chat/modules/messaging/models/message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'conv_event.dart';
part 'conv_state.dart';

class ConvBloc extends Bloc<ConvEvent, ConvState> {
  // TODO (abdelaziz): Refactor this more.
  // I don't have time now
  // so I am leaving it as is.
  static ConvBloc of(BuildContext context) =>
      BlocProvider.of<ConvBloc>(context);

  ConvBloc() : super(ConvInitial()) {
    on<ConvInitEvent>(_onConvInitEvent);
    on<ConvDeactvateEvent>(_onConvDeactvateEvent);
    on<ConvSendMsgEvent>(_onConvSendMessageEvent);
    on<ConvSetTypingEvent>(_onConvSetTypingEvent);
    on<ConvInitTypingStream>(_onConvInitTypingStream);
    on<ConvInitOnlineStream>(_onConvInitOnlineStream);
  }

  bool isGroup = false;
  List<UserModel> participants = [];
  List<MessageModel> messages = [];
  String title = "";
  String subtitle = "";
  bool isTyping = false;
  bool isOnline = false;
  String photo = "";
  String otherId = "";
  DateTime? lastSeen;
  final db = FirebaseFirestore.instance;
  String convId = "";
  Stream<QuerySnapshot<Map<String, dynamic>>>? msgsStream;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? typingStream;
  Stream? onlineStream;

  Future<void> _onConvInitEvent(
      ConvInitEvent event, Emitter<ConvState> emit) async {
    emit(ConvLoading());
    convId = event.convId;

    // Get convo information
    final conv = await db.collection("conversation").doc(convId).get();
    for (var part in conv.data()!['participants']) {
      final user = await db
          .collection("users")
          .doc(part)
          .withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();
      participants.add(user.data()!);
      if (part != AppSpMan.user.get()!.uid) {
        title = user.data()!.name;
        subtitle = user.data()!.email;
        photo = user.data()!.photo;
        otherId = part;
      }
    }
    emit(ConvLoaded());
    // List for realtime messages
    await _startMessagesStream(emit);
  }

  // TODO (abdelaziz): This should be refactored further for readablity, but I am running out
  // of time.
  Future<void> _startMessagesStream(Emitter<ConvState> emit) async {
    msgsStream = db
        .collection("conversation")
        .doc(convId)
        .collection("messages")
        .snapshots();
    await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(
      msgsStream!,
      onData: _onMsgsStream,
      onError: (event, error) => ConvError(error.toString()),
    );
  }

  ConvLoaded _onMsgsStream(QuerySnapshot<Map<String, dynamic>> event) {
    messages.clear();
    for (var doc in event.docs) {
      messages.add(MessageModel.fromJsonFirestore(
        doc.data(),
        participants,
      ));
    }
    messages.sort((a, b) => b.time.compareTo(a.time));
    return ConvLoaded();
  }

  FutureOr<void> _onConvDeactvateEvent(
      ConvDeactvateEvent event, Emitter<ConvState> emit) {
    msgsStream = null;

    isGroup = false;
    participants = [];
    messages = [];
    title = "";
    subtitle = "";
    photo = "";
    convId = "";
    emit(ConvInitial());
  }

  Future<void> _onConvSendMessageEvent(event, Emitter<ConvState> emit) async {
    final convRef = db.collection("conversation").doc(convId);
    final doc = convRef.collection("messages").doc();
    await doc.set({
      "id": doc.id,
      "sender": AppSpMan.user.get()!.uid,
      "text": event.text,
      "time": Timestamp.fromDate(DateTime.now()),
      "uuid": const Uuid().v4(),
    });
    final conv = await convRef.get();
    final cData = conv.data()!;
    cData["lastMessage"] = event.text;
    cData["lastMessageTime"] = Timestamp.fromDate(DateTime.now());
    cData['isActive'] = true;
    await convRef.set(cData);

    emit(ConvLoaded());
  }

  // DateTime? lastTypingUpdate;
  int minUpdatePeriodSecs = 2;

  Future<void> _onConvSetTypingEvent(
      ConvSetTypingEvent event, Emitter<ConvState> emit) async {
    await _setTyping();
    await Future.delayed(Duration(seconds: minUpdatePeriodSecs));
    await _unsetTyping();
  }

  Future<void> _setTyping() async {
    final ref = db.collection("conversation").doc(convId);
    final res = await ref.get();
    var data = res.data() ?? {};
    data["typing"] ??= {};
    data["typing"][AppSpMan.user.get()!.uid] = true;
    await ref.set(data);
  }

  Future<void> _unsetTyping() async {
    final ref = db.collection("conversation").doc(convId);
    final res = await ref.get();
    var data = res.data() ?? {};
    data["typing"] ??= {};
    data["typing"][AppSpMan.user.get()!.uid] = false;
    await ref.set(data);
  }

  Future<void> _onConvInitTypingStream(
      ConvInitTypingStream event, Emitter<ConvState> emit) async {
    await _startTypingStream(emit);
  }

  Future<void> _startTypingStream(emit) async {
    typingStream = db.collection("conversation").doc(convId).snapshots();
    await emit.forEach<DocumentSnapshot<Map<String, dynamic>>>(
      typingStream!,
      onData: _onTypingStream,
      onError: (event, error) => ConvError(error.toString()),
    );
  }

  ConvLoaded _onTypingStream(DocumentSnapshot<Map<String, dynamic>> event) {
    if (event.data()?["typing"] != null) {
      isTyping = event.data()!["typing"][otherId] ?? false;
    }
    return ConvLoaded();
  }

  Future<void> _onConvInitOnlineStream(
      ConvInitOnlineStream event, Emitter<ConvState> emit) async {
    await _startOnlineStream(emit);
  }

  Future<void> _startOnlineStream(Emitter<ConvState> emit) async {
    while (otherId.trim().isEmpty) {
      await Future.delayed(const Duration(seconds: 1));
    }
    onlineStream = Stream.periodic(
      Duration(seconds: minUpdatePeriodSecs),
      (i) async {
        final event = await db.collection("users").doc(otherId).get();
        if (event.data()?["lastOnline"] != null) {
          lastSeen = (event.data()!["lastOnline"] as Timestamp).toDate();
        }
        return event;
      },
    );
    // onlineStream = db.collection("users").doc(otherId).snapshots();
    await emit.forEach(
      onlineStream!,
      onData: (event) => ConvLoaded(),
      onError: (event, error) => ConvError(error.toString()),
    );
  }
}
