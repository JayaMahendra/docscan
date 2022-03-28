// // import 'package:document_scanner_flutter/configs/configs.dart';
// // import 'package:document_scanner_flutter/document_scanner_flutter.dart';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_document_scanner/flutter_document_scanner.dart';
// // import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// // import 'package:flutter_cache_manager/file.dart';

// class Scan extends StatefulWidget {
//   const Scan({Key? key}) : super(key: key);

//   @override
//   _ScanState createState() => _ScanState();
// }

// class _ScanState extends State<Scan> {
//   final _controller = DocumentScannerController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData.light().copyWith(
//           primaryColor: Colors.teal,
//         ),
//         home: Builder(builder: (context) {
//           return Scaffold(
//               body: DocumentScanner(
//                   controller: _controller,
//                   generalStyles: const GeneralStyles(
//                     baseColor: Colors.white,
//                   ),
//                   cropPhotoDocumentStyle: CropPhotoDocumentStyle(
//                     top: MediaQuery.of(context).padding.top,
//                   ),
//                   onSave: (Uint8List imageBytes) {
//                      print("image bytes: $imageBytes");
//                   }));
//         }));
// //   PDFDocument? _scannedDocument;
// //   File? _scannedDocumentFile;
// //   File? _scannedImage;

// //   openPdfScanner(BuildContext context) async {
// //     var doc = await DocumentScannerFlutter.launchForPdf(
// //       context,
// //       labelsConfig: {
// //         ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
// //         ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
// //         ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
// //             "Only {PAGES_COUNT} Page"
// //       },
// //       //source: ScannerFileSource.CAMERA
// //     );
// //     if (doc != null) {
// //       _scannedDocument = null;
// //       setState(() {});
// //       await Future.delayed(Duration(milliseconds: 100));
// //       _scannedDocumentFile = doc as File?;
// //       _scannedDocument = await PDFDocument.fromFile(doc);
// //       setState(() {});
// //     }
// //   }

// //   openImageScanner(BuildContext context) async {
// //     var image = await DocumentScannerFlutter.launch(context,
// //         //source: ScannerFileSource.CAMERA,
// //         labelsConfig: {
// //           ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
// //           ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
// //         });
// //     if (image != null) {
// //       _scannedImage = image as File?;
// //       setState(() {});
// //     }
// //   }

//     // @override
//     // Widget build(BuildContext context) {
//     //   return SafeArea(
//     //     child: Center(
//     //       child: Text(
//     //         "HALAMAN SCAN",
//     //         style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//     //       ),
//     //     ),
//     //   );

//     //  Widget build(BuildContext context) {
//     //   return MaterialApp(
//     //     home: Scaffold(
//     //       appBar: AppBar(
//     //         title: const Text('Document Scanner Demo'),
//     //       ),
//     //       body: Column(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         crossAxisAlignment: CrossAxisAlignment.center,
//     //         children: [
//     //           if (_scannedDocument != null || _scannedImage != null) ...[
//     //             if (_scannedImage != null)
//     //               Image.file(_scannedImage!,
//     //                   width: 300, height: 300, fit: BoxFit.contain),
//     //             if (_scannedDocument != null)
//     //               Expanded(
//     //                   child: PDFViewer(
//     //                 document: _scannedDocument!,
//     //               )),
//     //             Padding(
//     //               padding: const EdgeInsets.all(8.0),
//     //               child: Text(
//     //                   _scannedDocumentFile?.path ?? _scannedImage?.path ?? ''),
//     //             ),
//     //           ],
//     //           Center(
//     //             child: Builder(builder: (context) {
//     //               return ElevatedButton(
//     //                   onPressed: () => openPdfScanner(context),
//     //                   child: Text("PDF Scan"));
//     //             }),
//     //           ),
//     //           Center(
//     //             child: Builder(builder: (context) {
//     //               return ElevatedButton(
//     //                   onPressed: () => openImageScanner(context),
//     //                   child: Text("Image Scan"));
//     //             }),
//     //           )
//     //         ],
//     //       ),
//     //     ),
//     //   );
//   }
// }

import 'dart:io';

import 'package:docscan/theme.dart';
import 'package:flutter/material.dart';

import 'package:document_scanner/document_scanner.dart';
import 'package:opencv/core/core.dart';

import 'package:opencv/opencv.dart';
import 'package:permission_handler/permission_handler.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  File? scannedDocument;
  Future<PermissionStatus>? cameraPermissionFuture;
  dynamic res;

  @override
  void initState() {
    cameraPermissionFuture = Permission.camera.request();
    super.initState();
  }

  useFilter() async {
    res = await ImgProc.blur(await scannedDocument?.readAsBytes(), [45, 45],
        [20, 30], Core.borderReflect);
    setState(() {
      // scannedDocument = res; intinya inti

      // ScannedImage(croppedImage: res);

      // Image? img;
      // img = Image.memory(res); ga error tapi gaada perubahan
      // scannedDocument = img;
      
      // img: FileImage(scannedDocument!);
      // img = res;
      // Image(image: FileImage(scannedDocument!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: purple,
            title: const Text('Scanner App'),
          ),
          body: FutureBuilder<PermissionStatus>(
            future: cameraPermissionFuture,
            builder: (BuildContext context,
                AsyncSnapshot<PermissionStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.isGranted)
                  return Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: scannedDocument != null
                                ? Image(image: FileImage(scannedDocument!))
                                : DocumentScanner(
                                    // documentAnimation: false,
                                    noGrayScale: false,
                                    onDocumentScanned:
                                        (ScannedImage scannedImage) {
                                      print("document : " +
                                          scannedImage.croppedImage!);

                                      setState(() {
                                        scannedDocument = scannedImage
                                            .getScannedDocumentAsFile();
                                        // imageLocation = image;
                                      });
                                    },
                                  ),
                          ),
                        ],
                      ),
                      scannedDocument != null
                          ? Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: RaisedButton(
                                onPressed: () {
                                  useFilter();
                                },
                                child: Text("Blur"),
                              ),
                              // RaisedButton(
                              //     color: Colors.red,
                              //     child: Text("Retry"),
                              //     onPressed: () {
                              //       setState(() {
                              //         scannedDocument = null;
                              //       });
                              //     }),
                              // RaisedButton(
                              //   onPressed: () async {
                              //     res = await ImgProc.dilate(
                              //         await scannedDocument
                              //             ?.readAsBytes(),
                              //         [2, 2]);
                              //   },
                              //   child: Text("Dilate n 2D"),
                              // ),
                            )
                          : Container(),
                    ],
                  );
                else
                  return Center(
                    child: Text("Camera permission denied"),
                  );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
