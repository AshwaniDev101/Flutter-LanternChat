
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeTab extends StatelessWidget {
  ScanCodeTab({super.key});

  final MobileScannerController controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // final height = constraints.maxHeight;

          final scanSize = width * 0.7;

          return MobileScanner(
            controller: controller,
            tapToFocus: true,

            scanWindow: null,

            overlayBuilder: (context, constraints) {
              return Stack(
                children: [

                  // White border
                  Center(
                    child: Container(
                      width: scanSize,
                      height: scanSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              );
            },

            // fit: BoxFit.contain,
            onDetect: (BarcodeCapture capture) {
              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;

              if (code != null) {
                print("==== Qr Detected $code");

                controller.stop();

              }
            },
          );
        },
      ),
    );
  }
}
