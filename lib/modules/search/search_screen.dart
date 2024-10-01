import 'package:educately_chat/config/app_colors.dart';
import 'package:educately_chat/config/app_navigator.dart';
import 'package:educately_chat/config/app_size.dart';
import 'package:educately_chat/config/app_theme.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:educately_chat/modules/chats/bloc/chats_bloc.dart';
import 'package:educately_chat/modules/chats/widgets/chat_tile_widget.dart';
import 'package:educately_chat/modules/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = SearchBloc.of(context);
    return PopScope(
      onPopInvokedWithResult: (_, __) async {
        SearchBloc.of(context).add(SearchResetEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              SearchBloc.of(context).add(SearchResetEvent());
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: TextField(
            controller: controller,
            onChanged: (value) {
              SearchBloc.of(context).add(SearchQueryEvent(query: value));
            },
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search_rounded),
            ),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SearchError) {
              return Center(
                child: Text(state.message),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (bloc.conversations.isNotEmpty)
                    Text(
                      "Chats",
                      style: context.textTheme.s16.w600,
                    ),
                  if (bloc.conversations.isNotEmpty) const Divider(),
                  ...bloc.conversations.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: e.isActive
                            ? ChatTileWidget(model: e)
                            : _buildUserTile(e.user!, e.id),
                      )),
                  if (bloc.users.isNotEmpty)
                    Text(
                      "Users",
                      style: context.textTheme.s16.w600,
                    ),
                  if (bloc.users.isNotEmpty) const Divider(),
                  ...bloc.users.map((e) => _buildUserTile(e)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserTile(UserModel user, [String? convId]) {
    return InkWell(
      onTap: () {
        if (convId != null) {
          AppNavigator.goConversationScreen(context, convId: convId);
        } else {
          ChatsBloc.of(context).add(ChatsCreateConversationEvent(user: user));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(
                user.photo,
                height: 50.r,
                width: 50.r,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: context.textTheme.s18.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
          ],
        ),
      ),
    );
  }
}
