part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;

  const SearchQueryEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchResetEvent extends SearchEvent {}
