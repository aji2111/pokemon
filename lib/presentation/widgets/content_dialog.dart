import 'package:flutter/material.dart';

class DialogContent extends StatelessWidget {
  final String? nameContent;
  final Widget? icon;
  final Function() onTap;
  const DialogContent(
      {super.key, this.nameContent, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: icon ??
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
            ),
            SizedBox(height: 16),
            Text(
              nameContent!,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: Text('Tutup'),
        ),
      ],
    );
  }
}
