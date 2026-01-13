import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'
    show ScreenUtilInit;

import 'core/router/app_router.dart' show appRouter;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size designSize;
        if (constraints.maxWidth >= 1920) {
          designSize = const Size(1920, 1080); // large screens
        } else if (constraints.maxWidth >= 1440) {
          designSize = const Size(1440, 1024); // typical desktop
        } else if (constraints.maxWidth >= 1024) {
          designSize = const Size(1024, 768); // small laptops/tablets
        } else {
          designSize = const Size(768, 1024); // fallback (portrait/tablet)
        }

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,

          builder: (_, __) {
            return MaterialApp.router(
              title: 'Digify App',
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}








class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SimplePage(title: "Testimonials");
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SimplePage(title: "Contact Us");
  }
}

// Simple placeholder page layout
class _SimplePage extends StatelessWidget {
  final String title;

  const _SimplePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0F2C),
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}


