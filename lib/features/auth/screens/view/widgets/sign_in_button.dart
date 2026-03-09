
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {


  final String imageUrl;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback callback;

  const SignInButton({super.key, required this.imageUrl, required this.text, required this.textColor, required this.backgroundColor, required this.callback, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: callback,

        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                imageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight:FontWeight.bold, color: textColor), ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
