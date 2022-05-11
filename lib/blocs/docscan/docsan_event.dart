part of 'docsan_bloc.dart';

abstract class DocsanEvent extends Equatable {
  const DocsanEvent();

  @override
  List<Object> get props => [];
}

class LoadDocsanEvent extends DocsanEvent {
  final List<Dcmn> documents;

  const LoadDocsanEvent({this.documents = const <Dcmn>[]});

  @override
  List<Object> get props => [documents];
}

class AddDocsanEvent extends DocsanEvent {
  final Dcmn documents;

  const AddDocsanEvent({required this.documents});

  @override
  List<Object> get props => [documents];
}

class UpdateDocsanEvent extends DocsanEvent {
  final Dcmn documents;

  const UpdateDocsanEvent({required this.documents});

  @override
  List<Object> get props => [documents];
}

class DeleteDocsanEvent extends DocsanEvent {
  final Dcmn documents;

  const DeleteDocsanEvent({required this.documents});

  @override
  List<Object> get props => [documents];
}
