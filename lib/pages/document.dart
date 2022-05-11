import 'package:docscan/blocs/docscan/docsan_bloc.dart';
import 'package:docscan/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:docscan/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/model/document_model.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  // data2 == null ? DataKosong()

  Widget build(BuildContext context) {
    return
        // RepositoryProvider(
        // create: (_) => DocumentRepository(),
        // child:
        BlocProvider(
            create: (context) => DocsanBloc()..add(const LoadDocsanEvent()),
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('The Docscan App'),
                ),
                body: BlocBuilder<DocsanBloc, DocsanState>(
                    builder: (context, state) {
                  if (state is DocsanLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is DocsanLoadedState) {
                    // List<Dcmn> documents;
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          final docsans = state.docsans[index];
                          return Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                            child: Text(docsans.nama),
                          )));
                        });
                          // return Center(
                          //   child: Text('tes'),
                          // );

                    // return ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: state.documents.length,
                    //     itemBuilder: (context, index) {
                    // List<Dcmn> documents;
                    //       return Card(child: Text(documents.nama));
                    //     });
                  } else {
                    return const Text("Something went wrong! in list view");
                  }
                })));
  }
}
