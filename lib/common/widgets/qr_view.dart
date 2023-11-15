import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';

showQrCode(String qr, BuildContext context) async {
  final qrImageKey = GlobalKey();
  final mediaQuery = MediaQuery.of(context);
  final maxWidth =
      mediaQuery.size.width * 0.8; // Adjust the multiplier as needed
  final maxHeight = mediaQuery.size.height * 0.8; //
  //final RenderBox box = context.findRenderObject() as RenderBox;
  //final Offset offset = box.localToGlobal(Offset.zero);
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: qrImageKey,
              child: QrImageView(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
                data: qr,
                version: QrVersions.auto,
                size: min(maxWidth, maxHeight),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('fertig'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    saveQrCode(qr, context, qrImageKey);
                  },
                  child: const Text('code speichern'),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void saveQrCode(String qr, BuildContext context, GlobalKey qrKey) async {
  final RenderRepaintBoundary boundary =
      qrKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary; //final repaintBoundary = RepaintBoundary();
  // Wrap the QR image with a Container or SizedBox
  ui.Image image = await boundary.toImage();
  String? filePath =
      await FilePicker.platform.saveFile(allowedExtensions: ['png']);
  if (filePath == null) {
    // User canceled the file picker
    return;
  }
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData!.buffer.asUint8List();
  File imgFile = File(filePath);
  await imgFile.writeAsBytes(pngBytes);

  // Show a success message
  if (context.mounted) {
    snackbarSuccess(context, 'QR-Code gespeichert');
  }
}
