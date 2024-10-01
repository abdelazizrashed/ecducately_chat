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
  Widget build(BuildContext context) {
    final bloc = SearchBloc.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
              children: [
                ...bloc.conversations.map((e) => Text(e.toString())),
              ],
            ),
          );
        },
      ),
    );
  }
}
