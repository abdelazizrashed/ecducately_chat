import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:educately_chat/modules/chats/models/conversation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static SearchBloc of(BuildContext context) =>
      BlocProvider.of<SearchBloc>(context);

  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryEvent>(_onSearchQueryEvent);
    on<SearchResetEvent>(_onSearchResetEvent);
  }

  List<UserModel> users = [];
  List<ConversationModel> conversations = [];

  final db = FirebaseFirestore.instance;

  Future<void> _onSearchQueryEvent(
      SearchQueryEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final usersSnapshot = await db.collection("users").get();
    users.clear();
    conversations.clear();
    for (var doc in usersSnapshot.docs) {
      final data = doc.data();
      final name = data['name'] as String;
      final email = data['email'] as String;
      if (name
              .trim()
              .toLowerCase()
              .contains(event.query.trim().toLowerCase()) ||
          email
              .trim()
              .toLowerCase()
              .contains(event.query.trim().toLowerCase())) {
        final model = UserModel.fromJson(doc.data());
        final convo = await db
            .collection("conversation")
            .where("participants", arrayContains: model.uid)
            .get();
        if (convo.docs.isEmpty) {
          users.add(model);
        } else {
          final exist =
              conversations.map((e) => e.id).contains(convo.docs.first.id);
          if (!exist) {
            conversations.add(ConversationModel.fromJsonFirestore(
              convo.docs.first.data(),
              usersSnapshot.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList(),
            ));
          }
        }
      }
    }
    emit(SearchLoaded());
  }

  FutureOr<void> _onSearchResetEvent(
      SearchResetEvent event, Emitter<SearchState> emit) {
    users.clear();
    conversations.clear();
    emit(SearchInitial());
  }
}
