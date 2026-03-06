import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/view/scan_qr/scan_qr_tab_viewmodel.dart';

final scanStateQrNotifier = AutoDisposeNotifierProvider<QrNotifier, ScanState>(QrNotifier.new);