// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:docscan/repository/auth_repository.dart';
// import 'package:docscan/state/auth_state.dart';
// import 'package:docscan/pages/home.dart';
// import 'package:docscan/pages/login.dart';
// import 'blocs/Auth_bloc.dart';
// import 'event/auth_event.dart';

//   void main() {
//     // runApp(MyApp());
//     // BlocOverrides.runZoned(() => runApp(MyApp(
//     //       authRepository: authRepository,
//     //       authBloc: AuthBloc(authRepository: authRepository),
//     //     )));
//     final AuthRepository authRepository = AuthRepository();

//     runApp(BlocProvider(
//       create: (context) {
//         return AuthBloc(authRepository: authRepository);
//       },
//       child: MyApp(
//         authRepository: authRepository,
//         authBloc: AuthBloc(authRepository: authRepository),
//       ),
//     ));
//   }

// //   }
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(
// //           fontFamily: 'Poppins',
// //         ),
// //         home: HomePage());
// //   }

// class MyApp extends StatelessWidget {
//   final AuthRepository authRepository;
//   final AuthBloc authBloc;

//   const MyApp({Key? key, required this.authRepository, required this.authBloc})
//       : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocBuilder<AuthBloc, AuthState>(
//         bloc: authBloc,
//         builder: (context, AuthState state) {
//           if (state is AuthInit) {
//             authBloc.add(AuthCheck());
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is AuthHasToken || state is AuthData) {
//             return HomePage(
//               // authBloc: authBloc,
//             );
//           }
//           if (state is AuthFailed || state is LoginFailed) {
//             return LoginPage(
//               // authBloc: authBloc,
//             );
//           }
//           if (state is AuthLoading) {
//             return Container(
//               color: Colors.white,
//               child: const Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }

//           return Container();
//         },
//       ),
//     );
//   }
// }

// //  13-17 32-42

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';
//uncomment when image_picker is installed
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'opencv_4 Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  Uint8List? _byte, salida;
  String _versionOpenCV = 'OpenCV';
  bool _visible = false;
  //uncomment when image_picker is installed
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getOpenCVVersion();
  }

  testOpenCV({
    required String pathString,
    required CVPathFrom pathFrom,
    required double thresholdValue,
    required double maxThresholdValue,
    required int thresholdType,
  }) async {
    try {
      //test with threshold

// 
// code yang akan digunakan 
      _byte = await Cv2.filter2D(
        pathFrom: pathFrom,
        pathString: pathString,
        outputDepth: -1,
        kernelSize: [2,1],
// 
// 
        //2,1 oke
        //3,1 menurun 
        //41 jelek

        //22 buruk 23 buruk bett
        //2 21 oke, 

      );

      setState(() {
        _byte;
        _visible = false;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  /// metodo que devuelve la version de OpenCV utilizada
  Future<void> _getOpenCVVersion() async {
    String? versionOpenCV = await Cv2.version();
    setState(() {
      _versionOpenCV = 'OpenCV: ' + versionOpenCV!;
    });
  }

  _testFromAssets() async {
    testOpenCV(
      pathFrom: CVPathFrom.ASSETS,
      pathString: 'assets/Test.JPG',
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );
    setState(() {
      _visible = true;
    });
  }

  _testFromUrl() async {
    testOpenCV(
      pathFrom: CVPathFrom.URL,
      pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/16fe9f114930481.6044f05fca574.jpeg',
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );
    setState(() {
      _visible = true;
    });
  }

  _testFromCamera() async {
    //uncomment when image_picker is installed
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    testOpenCV(
      pathFrom: CVPathFrom.GALLERY_CAMERA,
      pathString: _image!.path,
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );

    setState(() {
      _visible = true;
    });
  }

  _testFromGallery() async {
    //uncomment when image_picker is installed
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    testOpenCV(
      pathFrom: CVPathFrom.GALLERY_CAMERA,
      pathString: _image!.path,
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );

    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _versionOpenCV,
                          style: TextStyle(fontSize: 23),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: _byte != null
                              ? Image.memory(
                                  _byte!,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  width: 300,
                                  height: 300,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                        Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: _visible,
                            child:
                                Container(child: CircularProgressIndicator())),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test assets'),
                            onPressed: _testFromAssets,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test url'),
                            onPressed: _testFromUrl,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test gallery'),
                            onPressed: _testFromGallery,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test camara'),
                            onPressed: _testFromCamera,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
