import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/qr/screens/view/scan_qr/qr_scan_tab.dart';
import 'package:lanternchat/features/qr/screens/view/show_qr/qr_show_tab.dart';
class QrCodePage extends ConsumerWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        // initialIndex: 1,
        // A scrollable widgets MUST know its size in the non-scroll direction.
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(child: Text("QR CODE")),
                Tab(child: Text("SCAN CODE")),


              ],
            ),
            Expanded(child: TabBarView(children: [ ShowQrTab(),ScanQrTab(),])),
          ],
        ),
      ),
    );
  }
}
