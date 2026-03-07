import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/users/contact.dart';

class QrScanState {
  final Contact contact;

  final bool isUserFound;
  final bool isCoolDown;

  // const ScanState({this.isUserFound = false, this.isQrScanningCoolDown = false, this.appUser});
  const QrScanState({this.isUserFound = false, this.isCoolDown = false, this.contact = Contact.empty});

  QrScanState copyWith({bool? isUserFound, bool? isCoolDown, Contact? contact}) {
    return QrScanState(
      isUserFound: isUserFound ?? this.isUserFound,
      isCoolDown: isCoolDown ?? this.isCoolDown,
      contact: contact ?? this.contact,
    );
  }
}

class QrScanStateNotifier extends AutoDisposeNotifier<QrScanState> {
  // Initial ScanState
  @override
  QrScanState build() {
    return QrScanState();
  }

  void userFound(bool isUserFound) {
    state = state.copyWith(isUserFound: isUserFound);
  }

  void setContact(Contact contact) {
    state = state.copyWith(contact: contact);
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
