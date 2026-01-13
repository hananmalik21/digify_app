import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/services/presentation/widgets/detailed_service_card.dart';
import 'package:digify_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExploreServicesPage extends StatelessWidget {
  const ExploreServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 750;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, isMobile),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(context, isMobile),
            
            // Services Grid Section
            _buildServicesSection(context, isMobile),
            
            // CTA Section
            _buildCTASection(context, isMobile),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isMobile) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, 
            color: Color(0xFF1A1A1A), 
            size: 18,
          ),
          onPressed: () => context.go('/'),
          padding: EdgeInsets.zero,
        ),
      ),
      title: Text(
        'Our Services',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: isMobile ? 20 : 24,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A1A1A),
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: false,
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF0F6FF),
            const Color(0xFFE8F2FF),
            Colors.white,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pill Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFF),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF165DFC).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  "Our Expertise",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF165DFC),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Main Title
              Text(
                "Comprehensive Digital\nServices",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A1929),
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 24),

              // Subtitle
              Container(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  "From concept to launch, we deliver end-to-end solutions that drive growth and transform your business",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 80,
        horizontal: isMobile ? 24 : 40,
      ),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Text(
                "What We Offer",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0A1929),
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 48),

              // Services List
              Column(
                children: _allServices.map((service) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: DetailedServiceCard(
                      image: service['image'] as String,
                      icon: service['icon'] as String,
                      title: service['title'] as String,
                      subtitle: service['subtitle'] as String,
                      description: service['description'] as String,
                      features: (service['features'] as List).cast<String>(),
                      benefits: (service['benefits'] as List).cast<String>(),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 80,
        horizontal: isMobile ? 24 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF165DFC),
            const Color(0xFF0E4ACC),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 40 : 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: -10,
                ),
              ],
            ),
            child: Column(
              children: [
                // Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF165DFC).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: Color(0xFF165DFC),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  "Ready to Get Started?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A1929),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    "Let's discuss how we can help transform your business with our comprehensive digital solutions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: isMobile ? 16 : 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // CTA Button
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF165DFC),
                    foregroundColor: Colors.white,
                    elevation: 8,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 32 : 48,
                      vertical: isMobile ? 16 : 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: const Color(0xFF165DFC).withOpacity(0.4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Contact Us Today",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ⭐ Service list with detailed information
final List<Map<String, dynamic>> _allServices = [
  {
    "image": Assets.images.mobDev.path,
    "icon": Assets.images.mobDevIcon,
    "title": "Mobile App Development",
    "subtitle": "iOS and Android applications",
    "description": "Transform your business with powerful, user-friendly mobile applications. We develop native and cross-platform apps that deliver exceptional user experiences and drive engagement across iOS and Android platforms.",
    "features": [
      "Native iOS (Swift) and Android (Kotlin) development",
      "Cross-platform solutions using Flutter and React Native",
      "App Store and Google Play Store optimization",
      "Real-time synchronization and offline capabilities",
      "Push notifications and analytics integration",
      "App maintenance and continuous updates",
    ],
    "benefits": [
      "Increased customer engagement and retention",
      "Access to a wider market through mobile platforms",
      "Enhanced brand visibility and recognition",
      "Streamlined business processes and operations",
      "Real-time data access and improved productivity",
      "Competitive advantage in the digital marketplace",
    ],
  },
  {
    "image": Assets.images.digitalMarketing.path,
    "icon": Assets.images.digitalMarketingIcon,
    "title": "Digital Marketing",
    "subtitle": "SEO, social media & content strategy",
    "description": "Boost your online presence and reach your target audience with our comprehensive digital marketing services. We create data-driven strategies that increase brand awareness, drive traffic, and generate quality leads.",
    "features": [
      "Search Engine Optimization (SEO) and SEM",
      "Social media marketing and management",
      "Content creation and content marketing",
      "Email marketing campaigns",
      "Pay-per-click (PPC) advertising",
      "Analytics and performance tracking",
    ],
    "benefits": [
      "Increased website traffic and lead generation",
      "Improved search engine rankings",
      "Enhanced brand awareness and visibility",
      "Better ROI on marketing investments",
      "Targeted audience engagement",
      "Measurable results and data-driven insights",
    ],
  },
  {
    "image": Assets.images.webDev.path,
    "icon": Assets.images.webDevIcon,
    "title": "Web Development",
    "subtitle": "Custom websites and web applications",
    "description": "Build powerful, scalable web solutions that drive business growth. From responsive websites to complex web applications, we create digital experiences that engage users and convert visitors into customers.",
    "features": [
      "Responsive and mobile-first design",
      "Custom web application development",
      "E-commerce solutions and online stores",
      "Content Management Systems (CMS)",
      "API development and integration",
      "Performance optimization and security",
    ],
    "benefits": [
      "Professional online presence",
      "Improved user experience and engagement",
      "Increased conversion rates",
      "Scalable solutions that grow with your business",
      "Enhanced security and data protection",
      "Better search engine visibility",
    ],
  },
  {
    "image": Assets.images.uiUx.path,
    "icon": Assets.images.uiUxIcon,
    "title": "UI/UX Design",
    "subtitle": "Beautiful user experiences",
    "description": "Create intuitive and visually stunning user interfaces that delight users and drive conversions. Our design team combines creativity with user research to deliver experiences that are both beautiful and functional.",
    "features": [
      "User research and persona development",
      "Wireframing and prototyping",
      "Visual design and branding",
      "User interface (UI) design",
      "User experience (UX) optimization",
      "Design system creation",
    ],
    "benefits": [
      "Improved user satisfaction and retention",
      "Higher conversion rates",
      "Reduced development costs through better planning",
      "Enhanced brand perception",
      "Increased user engagement",
      "Competitive advantage through superior design",
    ],
  },
  {
    "image": Assets.images.cloudFunction.path,
    "icon": Assets.images.cloudSolutionIcon,
    "title": "Cloud Solutions",
    "subtitle": "Scalable cloud infrastructure",
    "description": "Leverage the power of cloud computing to scale your business operations. We provide comprehensive cloud solutions including migration, infrastructure setup, and ongoing management to ensure optimal performance and security.",
    "features": [
      "Cloud migration and strategy",
      "AWS, Azure, and Google Cloud setup",
      "Infrastructure as Code (IaC)",
      "Cloud security and compliance",
      "Auto-scaling and load balancing",
      "24/7 monitoring and support",
    ],
    "benefits": [
      "Reduced infrastructure costs",
      "Improved scalability and flexibility",
      "Enhanced security and data protection",
      "Increased business agility",
      "Better disaster recovery",
      "Access to latest technologies and updates",
    ],
  },
];
