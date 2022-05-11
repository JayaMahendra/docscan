import 'package:docscan/blocs/docscan/docsan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/repository/auth_repository.dart';
import 'package:docscan/blocs/auth/auth_state.dart';
import 'package:docscan/pages/home.dart';
import 'package:docscan/pages/login.dart';
import 'package:path/path.dart';
import 'blocs/auth/Auth_bloc.dart';
import 'blocs/auth/auth_event.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  // final DocumentRepository documentRepository = DocumentRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => DocsanBloc()..add(LoadDocsanEvent())),
      BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: Container(),
      )
    ],
    // child: child)
    //   // MultiBlocProvider(
    //   create: (context) {
    //     // return DocsanBloc(_documentRepository: documentRepository);
    //     return AuthBloc(authRepository: authRepository);
    //   },
    child: MyApp(
      // docsanBloc: DocsanBloc(documentRepository),
      // documentRepository: documentRepository,
      authRepository: authRepository,
      authBloc: AuthBloc(authRepository: authRepository),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final AuthBloc authBloc;
  // final DocumentRepository documentRepository;
  // final DocsanBloc docsanBloc;

  const MyApp({Key? key, required this.authRepository, required this.authBloc})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder(
        bloc: authBloc,
        builder: (context, AuthState state) {
          if (state is AuthInit) {
            authBloc.add(AuthCheck());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthHasToken || state is AuthData) {
            return HomePage(
                // authBloc: authBloc,
                );
          }
          if (state is AuthFailed || state is LoginFailed) {
            return LoginPage(
              authBloc: authBloc,
            );
          }
          if (state is AuthLoading) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
