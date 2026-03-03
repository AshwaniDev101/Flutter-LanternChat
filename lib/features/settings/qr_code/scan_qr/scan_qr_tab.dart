import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';
import 'package:lanternchat/database/database_provider.dart';
import 'package:lanternchat/features/settings/qr_code/scan_qr/scan_qr_tab_viewmodel.dart';
import 'package:lanternchat/features/settings/qr_code/scan_qr/widget/add_user_card.dart';
import 'package:lanternchat/features/settings/qr_code/scan_qr/widget/shaded_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/constant_strings.dart';
import '../../../../models/app_user.dart';

class ScanQrTab extends ConsumerStatefulWidget {
  const ScanQrTab({super.key});

  @override
  ConsumerState<ScanQrTab> createState() => _ScanQrTabState();
}

class _ScanQrTabState extends ConsumerState<ScanQrTab> {
  late final MobileScannerController controller;

  @override
  void initState() {
    controller = MobileScannerController(detectionSpeed: DetectionSpeed.normal);
    controller.start();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
    final userFirestoreProvider = ref.watch(userFirestoreServiceProvider);

    final scanStateProvider = ref.watch(scanStateQrNotifier);

    // When Some User is found show the Card
    if (scanStateProvider.appUser != null) {
      return FoundUserCard(
        appUser: scanStateProvider.appUser!,
        onCancel: () {
          ref.read(scanStateQrNotifier.notifier).userFound(null);
        },
        onAdd: () {
          userFirestoreProvider.addConnection(currentUser.uid, scanStateProvider.appUser!);
          ref.read(scanStateQrNotifier.notifier).userFound(null);
        },
      );
    }

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MobileScanner(
            controller: controller,
            scanWindow: null,

            // transparent black overlay for qr code just for visuals no functionality
            overlayBuilder: (context, constraints) {
              return ShadedOverlay(
                boxConstraints: constraints,
                onClickFlash: () {
                  controller.toggleTorch();
                },
              );
            },

            onDetect: (BarcodeCapture capture) async {
              // this is the avoid qr detection spamming Snack bar
              if (scanStateProvider.isCoolDown) return;

              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;

              // We have code
              if (code != null && code.isNotEmpty) {
                print("==== Qr Detected $code");
                ref.read(scanStateQrNotifier.notifier).startCooldown();

                // Separating the appName (fullCode[0]) and userID (fullCode[1])
                final fullCode = code.split('/');

                // Is this QR is for my own app?
                // Yes
                if (fullCode[0].contains(ConstantString.appName)) {
                  final AppUser? foundAppUser = await userFirestoreProvider.fetchUser(fullCode[1]);

                  if (foundAppUser != null) {
                    print("==== Fetched user ${foundAppUser.name.toString()}");
                    ref.read(scanStateQrNotifier.notifier).userFound(foundAppUser);
                    controller.stop();
                  } else {
                    showSnackBar("User Not Found: $code");
                  }

                } else {
                  showSnackBar("Invalid QR Code: $code");
                }
              }
            },
          );
        },
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
