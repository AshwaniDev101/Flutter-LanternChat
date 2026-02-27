import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/constants/constant_strings.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';
import 'package:lanternchat/database/database_provider.dart';
import 'package:lanternchat/models/app_user.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeTab extends ConsumerStatefulWidget {
  const ScanCodeTab({super.key});

  @override
  ConsumerState<ScanCodeTab> createState() => _ScanCodeTabState();
}

class _ScanCodeTabState extends ConsumerState<ScanCodeTab> {
  late final MobileScannerController controller;
  AppUser? appUser;

  bool isQrScanningCoolDown = false;

  @override
  void initState() {
    super.initState();

    controller = MobileScannerController(detectionSpeed: DetectionSpeed.normal);
    controller.start();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userFirestoreService = ref.read(userFirestoreServiceProvider);
    final currentUser = ref.read(firebaseAuthProvider).currentUser;



    // Possible states
    // Successful QR card scan get user
    // Unsupported QR code
    if (appUser == null || currentUser == null) {
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

                // this is the avoid qr detection spamming Snack bar
                if(isQrScanningCoolDown) return;

                final barcode = capture.barcodes.first;
                final String? code = barcode.rawValue;

                if (code != null) {
                  print("==== Qr Detected $code");
                  _startCooldown();

                  final fullCode = code.split('/');
                  if (fullCode[0].contains(ConstantString.appName)) {
                    appUser = await userFirestoreService.fetchUser(fullCode[1]);

                    if (appUser == null) {
                      showSnackBar("Couldn't find the User: $code");
                      _startCooldown();

                    } else {
                      print("==== App User ${appUser!.name.toString()}");
                      // appUser = _appUser;

                      controller.stop();

                      setState(() {});
                    }
                    
                    Future.delayed(Duration(seconds: 5),(){
                      isQrScanningCoolDown = false;
                    });
                  } else {
                    showSnackBar("Invalid QR Code: $code");
                  }
                }
              },
            );
          },
        ),
      );
    } else {
      final avtarRadius = 40.0;

      final buttonCornerRadius = 16.0;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentGeometry.topCenter,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20 + avtarRadius, 20, 20),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Text(appUser!.name, style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: 8),
                        Text(appUser!.email, style: Theme.of(context).textTheme.bodyMedium),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        appUser = null;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusGeometry.only(
                                          topLeft: Radius.circular(buttonCornerRadius),
                                          bottomLeft: Radius.circular(buttonCornerRadius),
                                        ),
                                      ),

                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Cancel"),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      userFirestoreService.addConnection(currentUser.uid, appUser!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusGeometry.only(
                                          topRight: Radius.circular(buttonCornerRadius),
                                          bottomRight: Radius.circular(buttonCornerRadius),
                                        ),
                                      ),
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Add"),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('Add to Connections?', style: Theme.of(context).textTheme.labelSmall,),
                        )
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: -avtarRadius,
                  child: CircularUserAvatar(imageUrl: appUser!.photoURL, radius: avtarRadius),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }


  void _startCooldown() {
    isQrScanningCoolDown = true;
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isQrScanningCoolDown = false;
        });
      }
    });
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
