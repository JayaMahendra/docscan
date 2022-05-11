part of 'docsan_bloc.dart';

abstract class DocsanState extends Equatable {
  const DocsanState();

  @override
  List<Object> get props => [];
}

class DocsanLoadingState extends DocsanState {}

class DocsanLoadedState extends DocsanState {
  // final List<Dcmn> documents;

  // const DocsanLoadedState({this.documents = const <Dcmn>[]});

  List<Dcmn> docsans;

  DocsanLoadedState({required this.docsans});
}

class FailedToLoadState extends DocsanState {
  String error;

  FailedToLoadState({required this.error});
}
