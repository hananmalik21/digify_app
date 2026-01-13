import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🟡 Background Glow
        Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.yellow.withOpacity(0.25), Colors.transparent],
                  stops: const [0.0, 1.0],
                  radius: 1.2,
                ),
              ),
            ),
          ),
        ),

        // 🧱 Main Layout
        child,
      ],
    );
  }
}
