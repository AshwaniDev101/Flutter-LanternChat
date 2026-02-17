
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {


  final IconData icon;
  final String title;
  final String? subtitle;
  const ListItem({required this.icon, required this.title, this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700],),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(title,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),
              Text(title,style: Theme.of(context).textTheme.titleMedium,),
              if (subtitle != null)
                Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
