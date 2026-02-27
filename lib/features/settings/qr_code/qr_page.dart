import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';
import 'package:lanternchat/features/settings/qr_code/scan_qr/scan_qr_tab.dart';
import 'package:lanternchat/features/settings/qr_code/show_qr/show_qr_tab.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends ConsumerWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        // initialIndex: 1,
        // A scrollable widget MUST know its size in the non-scroll direction.
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(child: Text("QR CODE")),
                Tab(child: Text("SCAN CODE")),


              ],
            ),
            Expanded(child: TabBarView(children: [ ShowQrTab(),ScanCodeTab(),])),
          ],
        ),
      ),
    );
  }
}
