import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/app_user.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

final scanStateQrNotifier = AutoDisposeNotifierProvider<QrNotifier, ScanState>(QrNotifier.new);

class ScanState {
  final AppUser? appUser;

  // final bool isUserFound;
  final bool isCoolDown;

  // const ScanState({this.isUserFound = false, this.isQrScanningCoolDown = false, this.appUser});
  const ScanState({this.isCoolDown = false, this.appUser});

  ScanState copyWith({bool? isUserFound, bool? isCoolDown, AppUser? appUser}) {
    return ScanState(
      // isUserFound: isUserFound ?? this.isUserFound,
      isCoolDown: isCoolDown ?? this.isCoolDown,
      appUser: appUser,
    );
  }
}

class QrNotifier extends AutoDisposeNotifier<ScanState> {
  // Initial ScanState
  @override
  ScanState build() {
    return ScanState();
  }


  void userFound(AppUser? appUser) {
    state = state.copyWith(appUser: appUser);
  }

  void setCoolDown(bool isCoolDown) {
    state = state.copyWith(isCoolDown: isCoolDown);
  }

  void startCooldown() {
    setCoolDown(true);
    Future.delayed(const Duration(seconds: 5), () {
      setCoolDown(false);
    });
  }
}
