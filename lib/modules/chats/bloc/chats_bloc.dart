import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_logger.dart';
import 'package:educately_chat/config/app_sp_man.dart';
import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:educately_chat/modules/chats/models/conversation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  static ChatsBloc of(BuildContext context) =>
      BlocProvider.of<ChatsBloc>(context);

  ChatsBloc() : super(ChatsInitial()) {
    on<ChatsGetHistoryEvent>(_onChatsGetHistoryEvent);
  }
  final db = FirebaseFirestore.instance;

  List<ConversationModel> chats = [];
  List<UserModel> users = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatsStream;

  Future<void> _onChatsGetHistoryEvent(
      ChatsGetHistoryEvent event, Emitter<ChatsState> emit) async {
    emit(ChatsLoading());

    final res = await db
        .collection("users")
        .withConverter(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();
    users.clear();
    for (var doc in res.docs) {
      users.add(doc.data());
    }
    chatsStream = db.collection("conversation").snapshots();
    await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(
      chatsStream!,
      onData: _onChatsStream,
      onError: (event, error) => ChatsError(error.toString()),
    );
  }

  ChatsState _onChatsStream(QuerySnapshot<Map<String, dynamic>> data) {
    chats.clear();
    for (var doc in data.docs) {
      final model = ConversationModel.fromJsonFirestore(
        doc.data(),
        users,
      );
      if (model.participants.contains(AppSpMan.user.get()!.uid)) {
        chats.add(ConversationModel.fromJsonFirestore(
          doc.data(),
          users,
        ));
      }
    }
    chats.sort((a, b) => (b.lastMessageTime ?? DateTime.now())
        .compareTo(a.lastMessageTime ?? DateTime.now()));
    AppLogger.info(tag: "ChatsoBloc Stream", value: "Emit ConvLoaded");
    return ChatsLoaded();
  }
}
