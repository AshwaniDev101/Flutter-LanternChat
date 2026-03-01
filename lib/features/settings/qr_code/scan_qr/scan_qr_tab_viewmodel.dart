

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final scanQrProvider = AutoDisposeAsyncNotifierProvider<ScanQrNotifier,ScanState>(ScanQrNotifier.new);


class ScanState
{
  final bool isUserFound;

  const ScanState({this.isUserFound = false});

  ScanState copyWith({bool? isUserFound})
  {
    return ScanState(isUserFound: isUserFound ?? this.isUserFound);
  }


}

class ScanQrNotifier extends AutoDisposeAsyncNotifier<ScanState>
{
  @override
  FutureOr<ScanState> build() {
    return ScanState();
  }

  void onDetect(BuildContext context, BarcodeCapture barCode)
  {
    final code = barCode.barcodes.first.rawValue;

    showSnackBar(context,"Code found ${code}");
    print("======== ${code}");

    if (code.toString().contains('user')) {
      state.
      showSnackBar(context,  "wow user found");
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

}