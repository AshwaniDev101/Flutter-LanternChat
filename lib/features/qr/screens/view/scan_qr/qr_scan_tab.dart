import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/contact/provider/contact_providers.dart';
import 'package:lanternchat/features/qr/screens/view/scan_qr/widgets/add_user_card.dart';
import 'package:lanternchat/features/qr/screens/view/scan_qr/widgets/shaded_overlay.dart';
import 'package:lanternchat/models/users/contact.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../core/constants/constant_strings.dart';
import '../../../../auth/provider/auth_provider.dart';
import '../../../provider/qr_provider.dart';

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
    final currentUser = ref.watch(currentUserProvider);
    // final userFirestoreProvider = ref.watch(appServiceProvider);
    final contactService = ref.watch(contactServiceProvider);

    final scanStateProvider = ref.watch(qrScanStateNotifier);

    // When Some User is found show the Card
    if (scanStateProvider.isUserFound) {
      return UserContactCard(
        contact: scanStateProvider.contact,
        onCancel: () {
          ref.read(qrScanStateNotifier.notifier).userFound(false);
        },
        onAdd: () {
          contactService.addContact(thisContact: currentUser.toContact(), newContact: scanStateProvider.contact);
          ref.read(qrScanStateNotifier.notifier).userFound(false);
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
                onClickGallery: () {},
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
                // print("==== Qr Detected $code");
                ref.read(qrScanStateNotifier.notifier).startCooldown();

                // Separating the appName (fullCode[0]) and userID (fullCode[1])
                final fullCode = code.split('/');

                // Is this QR is for my own app?
                // Yes
                if (fullCode[0].contains(ConstantString.appName)) {
                  // final AppUser? foundAppUser = await userFirestoreProvider.fetchUser(fullCode[1]);
                  final Contact? contact = await contactService.fetchUser(fullCode[1]);

                  if (contact != null) {
                    // print("==== Fetched users ${foundAppUser.name.toString()}");
                    ref.read(qrScanStateNotifier.notifier).setContact(contact);
                    ref.read(qrScanStateNotifier.notifier).userFound(true);
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
