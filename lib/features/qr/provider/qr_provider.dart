import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/viewmodel/qr_scan_tab_viewmodel.dart';

final qrScanStateNotifier = AutoDisposeNotifierProvider<QrScanStateNotifier, QrScanState>(QrScanStateNotifier.new);