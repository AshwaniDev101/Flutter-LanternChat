import 'dart:ui';


import 'dart:ui';

class AppColors {
  // Brand Foundation – Soft, calming teal-blue base
  static const Color statusBar = Color(0xFF1E2937);        // Soft deep slate
  static const Color primary = Color(0xFF3B82A6);          // Muted teal
  static const Color secondary = Color(0xFF60A5C8);        // Soft powder blue accent

  // Neutrals & Backgrounds – Elevated, warm off-whites for reduced glare
  static const Color surface = Color(0xFFF8F5F0);          // Warm oatmeal off-white
  static const Color chatBackground = Color(0xFFF1EDE6);   // Slightly deeper warm neutral
  static const Color muteColor = Color(0xFF64748B);        // Consistent slate grey for secondary text

  // UI Elements
  static const Color selectedTileTickColor = Color(0xFF10B981); // Retained emerald (calm and complementary)
  static const Color verticalNavigationBarColor = Color(0xFF1E2937);

  // Chat - Sender (Soft Teal Theme)
  static const Color senderBubble = Color(0xFF3B82A6);
  static const Color senderBubbleTitle = Color(0xFFE0F0FA);    // Very soft light blue
  static const Color senderBubbleText = Color(0xFFFFFFFF);
  static const Color senderBubbleMuteColor = Color(0xFF93C5E0); // Soft blue-grey

  // Chat - Received (Neutral Theme)
  static const Color receivedBubble = Color(0xFFEAE6DF);       // Warm light slate (softer than cool grey)
  static const Color receivedBubbleTitle = Color(0xFF1E293B);  // Deep slate title
  static const Color receivedBubbleText = Color(0xFF334155);   // High-contrast deep slate text
  static const Color receivedBubbleMuteColor = Color(0xFF64748B);
}

class DarkAppColors {
  // Core app colors – Deep, atmospheric tones for comfort
  static const Color statusBar = Color(0xFF0A0F1A);        // Soft near-black (avoids pure black glare)
  static const Color primary = Color(0xFF4A9BC0);          // Brighter yet desaturated teal for visibility
  static const Color secondary = Color(0xFF7AB8D8);        // Soft accent blue

  static const Color surface = Color(0xFF1A2333);          // Deep warm slate (trending for dark mode)
  static const Color chatBackground = Color(0xFF0F1829);   // True soft dark background
  static const Color muteColor = Color(0xFF94A3B8);

  // UI Elements
  static const Color selectedTileTickColor = Color(0xFF34D399); // Soft emerald
  static const Color verticalNavigationBarColor = Color(0xFF1A2333);

  // Chat - Sender (Soft Vibrant)
  static const Color senderBubble = Color(0xFF2E7A9E);
  static const Color senderBubbleTitle = Color(0xFFBFDBF0);
  static const Color senderBubbleText = Color(0xFFFFFFFF);
  static const Color senderBubbleMuteColor = Color(0xFF93C5E0);

  // Chat - Received (Muted Slate)
  static const Color receivedBubble = Color(0xFF25334A);    // Soft deep slate
  static const Color receivedBubbleTitle = Color(0xFFF1F5F9);
  static const Color receivedBubbleText = Color(0xFFCBD5E1);
  static const Color receivedBubbleMuteColor = Color(0xFF64748B);
}