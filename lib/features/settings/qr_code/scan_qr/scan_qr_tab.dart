import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/settings/qr_code/scan_qr/scan_qr_tab_viewmodel.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrTab extends ConsumerStatefulWidget {
  const ScanQrTab({super.key});

  @override
  ConsumerState<ScanQrTab> createState() => _ScanQrTabState();
}

class _ScanQrTabState extends ConsumerState<ScanQrTab> {
  late final MobileScannerController controller;

  @override
  void initState() {
    controller = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
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
    final scanQrStateProvider = ref.watch(scanQrProvider);

    return scanQrStateProvider.when(
      data: (state) {

        if (state.isUserFound) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(child: Text("User Found")),
            ),
          );
        }

        return Center(
          child: MobileScanner(
            controller: controller,
            onDetect: (barCode) {
              final code = barCode.barcodes.first.rawValue;

              showSnackBar("Code found ${code}");
              print("======== ${code}");

              if (code.toString().contains('user')) {

                ref.read(scanQrProvider.notifier).markUserAsFound();
                showSnackBar("wow user found");
              }
            },
          ),
        );

      },
      error: (e, t) {
        return Text("Error $e");
      },
      loading: () {
        return CircularProgressIndicator();
      },


    );

  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
