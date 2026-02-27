import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/database/database_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanCodeTab extends ConsumerStatefulWidget {
  const ScanCodeTab({super.key});

  @override
  ConsumerState<ScanCodeTab> createState() => _ScanCodeTabState();
}

class _ScanCodeTabState extends ConsumerState<ScanCodeTab> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
    controller.start();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final userService = ref.read(userServiceProvider);



    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final width = constraints.maxWidth;
          // final height = constraints.maxHeight;

          final scanSize = width * 0.7;

          final scanRect = Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: scanSize,
            height: scanSize,
          );

          return MobileScanner(
            controller: controller,
            scanWindow: null,

            overlayBuilder: (context, constraints) {
              return Stack(
                children: [
                  // Full Screen Camera
                  IgnorePointer(
                    child: ClipPath(
                      clipper: _CutoutClipper(scanSize),
                      child: Container(color: Colors.black.withValues(alpha: 0.6)),
                    ),
                  ),

                  // White Border frame (Scan Area)
                  Positioned(
                    top: scanRect.bottom + 24,
                    left: 0,
                    right: 0,
                    // right: 0,
                    child: Center(
                      child: Text(
                        'Scan a LanternChat QR Code',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  // Addition Button
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IconButton(
                            // TODO Implement Image Picker
                            onPressed: () {},
                            icon: Icon(Icons.photo_library_outlined, color: Colors.white, size: 32),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.toggleTorch();
                              print("=========== Toogle torch");
                            },
                            icon: Icon(Icons.flash_off, color: Colors.white, size: 32),
                          ),
                        ],
                      ),
                    ),
                  ),

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
            onDetect: (BarcodeCapture capture) async {
              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;

              if (code != null) {
                print("==== Qr Detected $code");

                final appUser = await userService.fetchUser(code);


                if(appUser!=null)
                  {
                    print("==== App User ${appUser.name.toString()}");
                  }




                controller.stop();
              }
            },
          );
        },
      ),
    );
  }
}

class _CutoutClipper extends CustomClipper<Path> {
  final double scanSize;

  _CutoutClipper(this.scanSize);

  @override
  Path getClip(Size size) {
    // Full size rectangle
    final Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    // From Center we offset the rect shape
    final Rect scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanSize,
      height: scanSize,
    );

    // Outer path: Full screen
    final outerPath = Path()..addRect(fullRect);

    // Inner path: the area we want to KEEP visible (cut-out)
    // adding Rounded corner to inner rect path
    final innerPath = Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(16)));

    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
