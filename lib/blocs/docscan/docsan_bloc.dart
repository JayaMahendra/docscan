import 'package:bloc/bloc.dart';
import 'package:docscan/model/document_model.dart';
import 'package:docscan/repository/document_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/document_model.dart';

part 'docsan_event.dart';
part 'docsan_state.dart';

class DocsanBloc extends Bloc<DocsanEvent, DocsanState> {
  // final DocumentRepository _documentRepository;
  final _documentRepository = DocumentRepository();

  DocsanBloc() : super(DocsanLoadingState()) {
    on<LoadDocsanEvent>(_onLoadDocsan);
    on<AddDocsanEvent>(_onAddDocsan);
    on<UpdateDocsanEvent>(_onUpdateDocsan);
    on<DeleteDocsanEvent>(_onDeleteDocsan);
  }

  Future<void> _onLoadDocsan(LoadDocsanEvent event, emit) async {
    if (event is LoadDocsanEvent) {
      emit(DocsanLoadingState());
      try{
        final docsans = await _documentRepository.getData();
        emit(DocsanLoadedState(docsans: docsans));
      } catch (e) {
        emit(FailedToLoadState(error: e.toString()));
      }
    }
  }
  // void _onLoadDocsan(LoadDocsanEvent event, Emitter<DocsanState> emit) async {
  //   emit(
  //     DocsanLoadingState(),
  //   );
  //   try {
  //     final documents = await _documentRepository.getData();
  //     emit(DocsanLoadedState(documents: documents));
  //   } catch (e) {
  //     emit(FailedToLoadState(error: e.toString()));
  //   }
  // }

  void _onAddDocsan(AddDocsanEvent event, Emitter<DocsanState> emit) {}
  void _onUpdateDocsan(UpdateDocsanEvent event, Emitter<DocsanState> emit) {}
  void _onDeleteDocsan(DeleteDocsanEvent event, Emitter<DocsanState> emit) {}
}
