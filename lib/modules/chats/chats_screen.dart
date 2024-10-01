import 'package:educately_chat/config/app_strings.dart';
import 'package:educately_chat/modules/chats/bloc/chats_bloc.dart';
import 'package:educately_chat/modules/chats/widgets/chat_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ChatsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = ChatsBloc.of(context);
    bloc.add(ChatsGetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          if (state is ChatsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChatsError) {
            return Center(
              child: Text(state.message),
            );
          }
          return ListView.builder(
            itemCount: bloc.chats.length,
            itemBuilder: (context, index) {
              return ChatTileWidget(
                model: bloc.chats[index],
              );
            },
          );
        },
      ),
    );
  }
}
