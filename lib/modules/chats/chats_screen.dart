import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_size.dart';
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
        title: Row(
          children: [
            InkWell(
              onTap: () {
                AppNavigator.goSearch(context);
              },
              child: const Icon(Icons.search_rounded),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  AppStrings.appName,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                AppNavigator.goSettings(context);
              },
              child: const Icon(Icons.settings_rounded),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: BlocBuilder<ChatsBloc, ChatsState>(
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ChatTileWidget(
                    model: bloc.chats[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
