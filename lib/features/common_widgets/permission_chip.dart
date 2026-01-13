import 'package:flutter/material.dart';

class PermissionChip extends StatelessWidget {
  const PermissionChip({
    super.key,
    required this.permission,
    this.enableShadow = false,
  });

  final String permission;
  final bool enableShadow;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Chip(
        label: Text(permission),
        avatar: const Icon(Icons.vpn_key, size: 16),
        backgroundColor: Colors.white.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white.withOpacity(0.18)),
        ),
      ),
    );
  }
}
