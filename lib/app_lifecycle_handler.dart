import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/services/shared_preference/data/shared_preference_manager.dart';
import 'package:lanternchat/core/services/shared_preference/provider/shared_preference_provider.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';

import 'features/auth/provider/presence_provider.dart';

class AppLifecycleHandler extends ConsumerStatefulWidget {
  final Widget child;

  const AppLifecycleHandler({required this.child, super.key});

  @override
  ConsumerState<AppLifecycleHandler> createState() => _AppLifecycleHandlerState();
}

class _AppLifecycleHandlerState extends ConsumerState<AppLifecycleHandler> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _setOnline(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _setOnline(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setOnline(true);
    } else {
      _setOnline(false);
    }
  }

  void _setOnline(bool isOnline) {
    final spp = ref.read(sharedPreferencesProvider);
    final bool isVisible = spp.getBool(SharedData.onlineStatus) ?? true;

    final currentUser = ref.read(currentUserProvider);
    final up = ref.read(presenceServiceProvider);

    // single source of truth
    final bool finalStatus = isVisible ? isOnline : false;
    up.setOnlineStatus(uid: currentUser.uid, isOnline: finalStatus);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
