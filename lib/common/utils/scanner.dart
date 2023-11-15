import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';

Future<String?> scanner(BuildContext context) async {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode, BarcodeFormat.codebar],
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => Stack(
        children: [
          MobileScanner(
              controller: controller,
              // fit: BoxFit.contain,
              onDetect: (capture) {
                final Barcode barcode;
                barcode = capture.barcodes[0];
                debug.warning('Scan result: ${barcode.displayValue}');
                Navigator.pop(context, barcode.displayValue);
                controller.dispose();
              }),
        ],
      ),
    ),
  );
  return result;
}
