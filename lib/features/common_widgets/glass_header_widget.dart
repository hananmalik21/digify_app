import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Glass header / cover widget
///
/// [isMobile] → controls layout:
///   - true  → buttons under title
///   - false → buttons on the right
///
/// [showButtons] → if false, hides Filter / Export buttons completely.
Widget buildGlassCover(
    BuildContext context,
    bool isMobile,
    String title, {
      bool showButtons = true,
    }) {
  final theme = Theme.of(context);
  final primary = theme.primaryColor;
  final secondary = theme.colorScheme.secondary;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
    ),
    width: double.infinity,
    height: isMobile ? 0.17.sh : 0.1.sh, // more height for mobile layout
    child: Stack(
      fit: StackFit.expand,
      children: [
        // 🎨 Background gradient using theme colors
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary.withOpacity(0.98),
                  secondary.withOpacity(0.95),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),

        // 🧊 Glass panel
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white.withOpacity(0.08),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 26,
                vertical: isMobile ? 12 : 14,
              ),
              child: _HeaderContent(
                title: title,
                isMobile: isMobile,
                showButtons: showButtons,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// Shared header content for both mobile & desktop
class _HeaderContent extends StatelessWidget {
  const _HeaderContent({
    required this.title,
    required this.isMobile,
    required this.showButtons,
  });

  final String title;
  final bool isMobile;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    final subtitle = 'Overview of all $title and key status';

    // 📱 Mobile layout: title + subtitle + buttons underneath
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.grid_view_rounded,
                  color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),

          if (showButtons) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _GlassButton(
                    icon: Icons.filter_list_rounded,
                    label: 'Filter',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _GlassButton(
                    icon: Icons.download_rounded,
                    label: 'Export',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    }

    // 💻 Desktop layout: title on left, buttons on right
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: title + icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.grid_view_rounded,
                  color: Colors.white, size: 26),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.2,
                  height: 1.1,
                ),
              ),
            ],
          ),

          // Right side: buttons (optional)
          if (showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _GlassButton(
                  icon: Icons.filter_list_rounded,
                  label: 'Filter',
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _GlassButton(
                  icon: Icons.download_rounded,
                  label: 'Export',
                  onTap: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _GlassButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.16),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: Colors.white.withOpacity(0.30),
            width: 1,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ).copyWith(
        // Hover / pressed overlay
        overlayColor: MaterialStatePropertyAll(
          Colors.white.withOpacity(0.10),
        ),
      ),
    );
  }
}

// Optional: if you later want pills, you can re-enable this class
// class _GlassPill extends StatelessWidget {
//   final String label;
//   final IconData? icon;
//   final bool dot;
//   final bool subtle;
//
//   const _GlassPill({
//     required this.label,
//     this.icon,
//     this.dot = false,
//     this.subtle = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final primary = theme.primaryColor;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(999),
//         color: Colors.black.withOpacity(subtle ? 0.10 : 0.18),
//         border: Border.all(
//           color: Colors.white.withOpacity(subtle ? 0.18 : 0.34),
//           width: 0.7,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (dot)
//             Container(
//               width: 8,
//               height: 8,
//               margin: const EdgeInsets.only(right: 5),
//               decoration: BoxDecoration(
//                 color: primary.withOpacity(0.95),
//                 shape: BoxShape.circle,
//               ),
//             )
//           else if (icon != null) ...[
//             Icon(icon, size: 13, color: Colors.white70),
//             const SizedBox(width: 4),
//           ],
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 10,
//               color: Colors.white70,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
