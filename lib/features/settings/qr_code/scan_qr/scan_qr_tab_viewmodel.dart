import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final scanQrProvider = AutoDisposeAsyncNotifierProvider<ScanQrNotifier, ScanState>(ScanQrNotifier.new);

class ScanState {
  final bool isUserFound;

  const ScanState({this.isUserFound = false});

  ScanState copyWith({bool? isUserFound}) {
    return ScanState(isUserFound: isUserFound ?? this.isUserFound);
  }
}

class ScanQrNotifier extends AutoDisposeAsyncNotifier<ScanState> {
  @override
  FutureOr<ScanState> build() {
    return ScanState();
  }

  void markUserAsFound() {
    state = state.whenData(
          (value) => value.copyWith(isUserFound: true),
    );
  }
}
