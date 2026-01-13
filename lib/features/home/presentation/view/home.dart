import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/about_us/presentation/view/about_us.dart';
import 'package:digify_app/features/contact_us/presentation/view/contact_us_view.dart';
import 'package:digify_app/features/home/presentation/widgets/hero_widget.dart';
import 'package:digify_app/features/portfolios/presentation/view/portfolios_view.dart';
import 'package:digify_app/features/services/presentation/view/service_view.dart';
import 'package:digify_app/features/testimonals/presentation/view/testimonals_view.dart';
import 'package:digify_app/features/why_choose_us/presentation/view/portfolio_view.dart';
import 'package:digify_app/gen/assets.gen.dart' show Assets;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // SECTION KEYS
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _whyChooseUs = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _menuKey = GlobalKey(); // for mobile menu button

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      alignment: 0, // top of section
    );
  }

  Widget _navButton(String text, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      child: Text(
        text,
        style: context.text16SemiBold.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _sectionWrapper({required GlobalKey key, required Widget child}) {
    final h = MediaQuery.of(context).size.height;

    return Container(
      key: key,
      constraints: BoxConstraints(
        minHeight: h, // full-screen section, can grow if needed
      ),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: width > 800 ? 100 : 56,
        backgroundColor: const Color(0xFF23293A),
        elevation: 0,
        title: Row(
          children: [
            if (width > 800) 100.horizontalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SvgPicture.asset(
                Assets.images.logo,
                height: 32,
              ),
            ),
          ],
        ),
        actions: [
          if (width > 800) ...[
            _navButton("Home", _heroKey),
            _navButton("About Us", _aboutKey),
            _navButton("Our Services", _servicesKey),
            _navButton("Why Choose Us", _whyChooseUs),
            _navButton("Portfolios", _portfolioKey),
            _navButton("Testimonials", _testimonialsKey),
            _navButton("Contact Us", _contactKey),
            const SizedBox(width: 16),
          ] else ...[
            IconButton(
              key: _menuKey,
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => showBreadcrumbPopup(context, _menuKey),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            /// HERO
            _sectionWrapper(key: _heroKey, child: const HeroSection()),

            /// ABOUT
            _sectionWrapper(key: _aboutKey, child: const AboutUsSection()),

            /// SERVICES
            _sectionWrapper(key: _servicesKey, child: const ServicesSection()),

            /// WHY CHOOSE US
            _sectionWrapper(
              key: _whyChooseUs,
              child: const WhyChooseUsSection(),
            ),

            /// PORTFOLIOS
            _sectionWrapper(
              key: _portfolioKey,
              child: const PortfoliosView(),
            ),

            /// TESTIMONIALS
            _sectionWrapper(
              key: _testimonialsKey,
              child: const TestimonialsSection(),
            ),

            /// CONTACT US
            _sectionWrapper(
              key: _contactKey,
              child: const ContactUsSection(),
            ),

            /// FOOTER (not full-height)
            FooterSection(
              onNavTap: _scrollTo,
              aboutKey: _aboutKey,
              servicesKey: _servicesKey,
              whyChooseKey: _whyChooseUs,
              portfolioKey: _portfolioKey,
              testimonialsKey: _testimonialsKey,
              contactKey: _contactKey,
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────── MOBILE BREADCRUMB POPUP ─────────────────

  void showBreadcrumbPopup(BuildContext context, GlobalKey key) {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu<int>(
      context: context,
      elevation: 0,
      color: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height + 8,
        position.dx + size.width,
        0,
      ),
      items: [
        popupItem(context, "Home", Icons.home_outlined, _heroKey),
        popupItem(context, "About Us", Icons.info_outline, _aboutKey),
        popupItem(context, "Our Services", Icons.build_outlined, _servicesKey),
        popupItem(
          context,
          "Why Choose Us",
          Icons.verified_outlined,
          _whyChooseUs,
        ),
        popupItem(
          context,
          "Portfolios",
          Icons.dashboard_outlined,
          _portfolioKey,
        ),
        popupItem(
          context,
          "Testimonials",
          Icons.people_alt_outlined,
          _testimonialsKey,
        ),
        popupItem(context, "Contact Us", Icons.call_outlined, _contactKey),
      ],
    );
  }

  PopupMenuItem<int> popupItem(
      BuildContext context,
      String title,
      IconData icon,
      GlobalKey targetKey,
      ) {
    return PopupMenuItem<int>(
      value: 0,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          _scrollTo(targetKey);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────── FOOTER WIDGET ─────────────────────

typedef ScrollToSection = Future<void> Function(GlobalKey key);

class FooterSection extends StatelessWidget {
  final ScrollToSection? onNavTap;
  final GlobalKey? aboutKey;
  final GlobalKey? servicesKey;
  final GlobalKey? whyChooseKey;
  final GlobalKey? portfolioKey;
  final GlobalKey? testimonialsKey;
  final GlobalKey? contactKey;

  const FooterSection({
    super.key,
    this.onNavTap,
    this.aboutKey,
    this.servicesKey,
    this.whyChooseKey,
    this.portfolioKey,
    this.testimonialsKey,
    this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF050B2B),
            Color(0xFF050821),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOP ROW
                  isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogoAndNav(context, isMobile),
                      const SizedBox(height: 24),
                      _buildNewsletter(context, isMobile),
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildLogoAndNav(context, isMobile),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 4,
                        child: _buildNewsletter(context, isMobile),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Divider(color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 16),

                  // BOTTOM ROW
                  isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "© 2024 DigifyApps. All rights reserved.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildBottomLinks(),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "© 2024 DigifyApps. All rights reserved.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      _buildBottomLinks(),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // LOGO + NAV LINKS
  Widget _buildLogoAndNav(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          Assets.images.logo,
          height: 32,
          colorFilter:
          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 32,
          runSpacing: 10,
          children: [
            _footerNavItem("About Us", aboutKey),
            _footerNavItem("Services", servicesKey),
            _footerNavItem("Why Choose Us", whyChooseKey),
            _footerNavItem("Portfolio", portfolioKey),
            _footerNavItem("Testimonials", testimonialsKey),
            _footerNavItem("Contact Us", contactKey),
          ],
        ),
      ],
    );
  }

  Widget _footerNavItem(String label, GlobalKey? key) {
    final hasKey = key != null && onNavTap != null;
    return InkWell(
      onTap: hasKey ? () => onNavTap!(key!) : null,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    );
  }

  // NEWSLETTER
  Widget _buildNewsletter(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Newsletter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _newsletterField(fullWidth: true),
            const SizedBox(height: 10),
            _subscribeButton(fullWidth: true),
          ],
        )
            : Row(
          children: [
            Expanded(child: _newsletterField()),
            const SizedBox(width: 12),
            _subscribeButton(),
          ],
        ),
      ],
    );
  }

  Widget _newsletterField({bool fullWidth = false}) {
    return SizedBox(
      height: 44,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "backend@brigade.dev",
          hintStyle: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          filled: true,
          fillColor: const Color(0xFF0B102B),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _subscribeButton({bool fullWidth = false}) {
    return SizedBox(
      height: 44,
      width: fullWidth ? double.infinity : 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // TODO: handle subscribe
        },
        child: const Text(
          "Subscribe",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // BOTTOM LINKS (Terms / Privacy / Cookies)
  Widget _buildBottomLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _BottomLink(label: "Terms"),
        SizedBox(width: 24),
        _BottomLink(label: "Privacy"),
        SizedBox(width: 24),
        _BottomLink(label: "Cookies"),
      ],
    );
  }
}

class _BottomLink extends StatelessWidget {
  final String label;

  const _BottomLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 13,
      ),
    );
  }
}
