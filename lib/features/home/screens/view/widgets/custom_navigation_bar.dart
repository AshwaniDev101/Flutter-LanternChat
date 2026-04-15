import 'package:flutter/material.dart';
import 'package:lanternchat/core/theme/app_colors.dart';
import 'package:lanternchat/core/theme/custom_theme.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_NavItem> items = const [
    _NavItem(Icons.chat, "Chats"),
    _NavItem(Icons.call, "Contacts"),
    _NavItem(Icons.qr_code, "QR"),
    _NavItem(Icons.settings, "Settings"),
  ];

  @override
  Widget build(BuildContext context) {

    // final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: customTheme.verticalNavBar,
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          return NavigationBarIcon(
            iconData: item.icon,
            label: item.label,
            selected: isSelected,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}

class NavigationBarIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NavigationBarIcon({
    super.key,
    required this.iconData,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              color: selected ? AppColors.primary : AppColors.muteColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: selected ? AppColors.primary : AppColors.muteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}