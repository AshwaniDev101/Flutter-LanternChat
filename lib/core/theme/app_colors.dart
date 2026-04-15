import 'dart:ui';


class AppColors {
  static const Color statusBar = Color(0xFF1B2F40);   // deeper navy

  static const Color primary = Color(0xFF2F5D7A);     // main brand blue
  static const Color secondary = Color(0xFF6FA9D6);   // lighter friendly blue

  static const Color surface = Color(0xFFF5F7F9);  // soft neutral background
  static const Color muteColor = Color(0xFF9AA4AE);   // modern muted grey

  // Chat
  static const Color senderBubble = Color(0xFF96ACBF);   // derived from secondary
  static const Color receivedBubble = Color(0xFFDDDADA); // subtle neutral
  // static const Color receivedBubble = Color(0xFFE3E7EB); // subtle neutral

  //388E3CFF 388E3CFF
  static const Color selectedTileTickColor = Color(0xFF6FC753); // subtle neutral


  static const Color chatBackground = Color(0xFFF5F7F9);


  static const Color verticalNavigationBarColor = Color(0xFF1B2F40);



}



// class DarkAppColors {
//   static const Color statusBar = Color(0xFF0D1B2A);   // deep navy (not pure black)
//
//   static const Color primary = Color(0xFF1B3A4B);     // muted dark blue
//   static const Color secondary = Color(0xFF4EA8DE);   // vibrant accent blue
//
//   static const Color surface = Color(0xFF1E293B);     // cards / containers
//   static const Color muteColor = Color(0xFF94A3B8);   // soft grey text
//
//   // Chat
//   static const Color senderBubble = Color(0xFF2563EB);   // strong blue (you)
//   static const Color receivedBubble = Color(0xFF1E293B); // dark neutral
//
//   static const Color chatBackground = Color(0xFF2A3F71);
//
//   static const Color verticalNavigationBarColor = Color(0xFF1B2F40);
//
// }



class DarkAppColors {
  // Core app colors (unchanged for consistency)
  static const Color statusBar = Color(0xFF0D1B2A);     // deep navy
  static const Color primary = Color(0xFF1B3A4B);       // muted dark blue
  static const Color secondary = Color(0xFF4EA8DE);     // vibrant accent blue
  static const Color surface = Color(0xFF1E293B);       // cards / containers
  static const Color muteColor = Color(0xFF94A3B8);     // soft grey text

  // Improved Chat Colors
  static const Color senderBubble = Color(0xFF3B82F6);  // Slightly softer blue (less saturated than 2563EB)
  static const Color receivedBubble = Color(0xFF334155); // Subtly lighter neutral for better separation
  static const Color chatBackground = Color(0xFF0F172A); // Deeper, more immersive background (rich navy-black)

  // Additional helpful colors for chat UI
  static const Color senderBubbleText = Color(0xFFFFFFFF);     // White text on sender bubble
  static const Color receivedBubbleText = Color(0xFFF1F5F9);   // Very light grey for received messages
  static const Color chatTimestamp = Color(0xFF64748B);        // Muted timestamp color

  static const Color verticalNavigationBarColor = Color(0xFF1B2F40);

}
