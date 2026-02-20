import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final ({IconData icon, VoidCallback onTap})? additionalOption;

  const NewButton({required this.icon, required this.title, required this.onTap, this.additionalOption, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).secondaryHeaderColor),
              child: Icon(icon,size: 24,),
            ),
            SizedBox(width: 20),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(width: 20),
            if (additionalOption != null)
              Spacer(),
              InkWell(
                onTap: additionalOption?.onTap,
                child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(additionalOption?.icon,)),
              ),
              SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}
