// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:schuldaten_hub/models/pupil/pupil_base.dart';
// import 'package:schuldaten_hub/views/widgets/snackbars.dart';
// import 'package:watch_it/watch_it.dart';

// import 'debug_printer.dart';

// class QrScanner extends WatchingStatefulWidget {
//   const QrScanner({super.key});

//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }

// class _QrScannerState extends State<QrScanner> {
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       if (Platform.isAndroid) {
//         controller!.pauseCamera();
//       }
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final pupilBaseList = ref.watch(pupilBaseProvider);
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//         ],
//       ),
//     );
//   }

//   processEncryptedQr(scanResult) async {
//     try {
//       //- TO-DO: uncomment encryption
//       //final resultString = CustomEncrypter().decrypt(scanResult.code);
//       //- Let's get the string from the scan result

//       final String resultString = scanResult.code;

//       //- The '***' is to ensure that this is our pupilbase qr, otherwise it will give an error
//       if (resultString.substring(0, 3) != '***') {
//         debug.error('This QR-Code is not a pupilBase! | ${StackTrace.current}');

//         snackbarError(context, 'This QR-Code is not a pupilBase!');
//         Navigator.of(context).pop();
//         return;
//       }
//       //- Let's take the '***' out of the string
//       String cleanString = resultString.substring(3);
//       //- The pupils in the string are separated by a '#' - let's split them out
//       List splittedPupils = cleanString.split('#');

//       debug.info('splittedpupils are $splittedPupils | ${StackTrace.current}');
//       //- The properties are separated by commas, let's build the pupilbase objects with them
//       final List<PupilBase> scannedPupilBase = splittedPupils
//           .map(
//             (element) => PupilBase(
//                 id: int.parse(element.split(',')[0]),
//                 name: element.split(',')[1] as String,
//                 lastName: element.split(',')[2] as String,
//                 schoolyear: element.split(',')[3] as String,
//                 group: element.split(',')[4] as String,
//                 language: element.split(',')[5] as String,
//                 migrationSupportEnds: element.split(',')[6] == '_'
//                     ? null
//                     : DateTime.tryParse(element.split(',')[6])),
//           )
//           .toList();

//       debugPrint(
//           'Pupils: ${scannedPupilBase[0].name}, ${scannedPupilBase[1].name}');
//       //- Now send the new pupilbase to the provider!
//       // ref
//       //     .read(pupilBaseProvider.notifier)
//       //     .addNewPupilBase(ref, scannedPupilBase);
//       snackbarSuccess(
//           context, 'Die neuen ID-Schlüssel wurden eingelesen und hinzugefügt!');
//       // ref.read(pupilProvider.notifier);
//       Navigator.of(context).pop();
//     } catch (e) {
//       debug.error('Error: ${e.toString()} | ${StackTrace.current}');

//       snackbarError(context, 'Scan Fehler, bitte erneut versuchen!');
//     }
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 200.0
//         : 400.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 5,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });

//     controller.scannedDataStream.listen((scanData) {
//       //controller.stopCamera();
//       controller.dispose();
//       processEncryptedQr(scanData);
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       snackbarError(context, 'No camera permission!');
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
