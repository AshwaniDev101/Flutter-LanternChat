
import 'package:flutter/material.dart';

class ColumnButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool showToggle;
  const ColumnButton({required this.icon, required this.title, this.subtitle, this.showToggle=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: 18),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),

                    if (subtitle != null)
                      Text(subtitle!, softWrap: true, style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),

              if (showToggle) Switch(value: false, onChanged: (value) {}),
            ],
          ),
        ),
      ),
    );
  }
}
