import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/helpers/timer_formate_helper.dart';
import 'package:lanternchat/models/users/user_presence.dart';

import '../../features/auth/provider/presence_provider.dart';

/// Displays user presence online/offline
///
/// Modes:
/// - Dot only:  showOnlyDot = true
/// - Text only: showTextOnly = true
class OnlineUserPresence extends ConsumerWidget {
  final String uid;
  final double size;
  final Color onlineColor;
  final Color offlineColor;

  /// Show only the status dot (no text)
  final bool showOnlyDot;

  /// Show only text (no dot)
  final bool showTextOnly;

  const OnlineUserPresence({
    required this.uid,
    this.size = 12,
    this.onlineColor = Colors.green,
    this.offlineColor = Colors.grey,
    this.showOnlyDot = false,
    this.showTextOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenceMap = ref.watch(presenceMapProvider);
    final userPresence = presenceMap[uid];

    if (userPresence == null) return const SizedBox();

    final bool isOnline = userPresence.isOnline;

    /// Decide what to show
    final bool showDot = !showTextOnly;
    final bool showText = !showOnlyDot;

    final String text = isOnline
        ? 'Online'
        : TimeFormatHelper.formatRelativeTime(userPresence.lastSeen);

    final Color color = isOnline ? onlineColor : offlineColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDot)
          Icon(Icons.circle, size: size, color: color),

        if (showDot && showText)
          const SizedBox(width: 4),

        if (showText)
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}