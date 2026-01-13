import 'package:digify_app/core/extensions/colors.dart';
import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({super.key, required this.onTap, required this.title});

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 16.0, top: 12.0),
        child: FilledButton.icon(
          onPressed: onTap,
          icon: Icon(Icons.add),
          label: Text(title),
          style: FilledButton.styleFrom(
            backgroundColor: context.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
