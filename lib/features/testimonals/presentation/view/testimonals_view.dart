import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
// import your context extensions / assets if you want
// import 'package:digify_app/core/extensions/textstyles.dart';
// import 'package:digify_app/core/extensions/colors.dart';
// import 'package:digify_app/gen/assets.gen.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 pill
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2EBFF),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Testimonials",
                  style: TextStyle(
                    color: Color(0xFF165DFC),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 main heading
              const Text(
                "What Our Clients Say",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 subheading text
              const Text(
                "Discover experiences shared by our trusted clients",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6B7280),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 60),

              // 🔹 slider
              _TestimonialsCarousel(testimonials: _dummyTestimonials),
            ],
          ),
        ),
      ),
    );
  }
}
class _TestimonialsCarousel extends StatefulWidget {
  final List<Testimonial> testimonials;

  const _TestimonialsCarousel({required this.testimonials});

  @override
  State<_TestimonialsCarousel> createState() => _TestimonialsCarouselState();
}

class _TestimonialsCarouselState extends State<_TestimonialsCarousel> {
  PageController? _controller;
  int _itemsPerPage = 3;
  int _currentPage = 0;

  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    // Start auto sliding
    _startAutoSlide();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(
      const Duration(seconds: 4),
          (_) {
        if (_controller == null) return;

        final nextPage = (_currentPage + 1) % _pageCount;

        _controller!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  void _goToPage(int index) {
    if (_controller == null) return;

    index = index.clamp(0, _pageCount - 1);
    _controller!.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  int get _pageCount =>
      (widget.testimonials.length / _itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 🔹 responsive columns
        int perPage = 3;
        if (constraints.maxWidth < 1000) perPage = 2;
        if (constraints.maxWidth < 700) perPage = 1;

        // recreate controller & restart autoplay when layout changes
        if (_controller == null || _itemsPerPage != perPage) {
          _controller?.dispose();
          _controller = PageController();
          _itemsPerPage = perPage;
          _currentPage = 0;
          _startAutoSlide();
        }

        return Column(
          children: [
            SizedBox(
              height: 320,
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageCount,
                onPageChanged: (i) {
                  setState(() => _currentPage = i);
                  _startAutoSlide(); // restart timer after manual swipe
                },
                itemBuilder: (context, pageIndex) {
                  final start = pageIndex * _itemsPerPage;
                  final end = min(
                    start + _itemsPerPage,
                    widget.testimonials.length,
                  );
                  final slice =
                  widget.testimonials.sublist(start, end);

                  return Row(
                    mainAxisAlignment: _itemsPerPage == 1
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      for (final t in slice)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: _itemsPerPage == 1 ? 0 : 8,
                            ),
                            child: _TestimonialCard(testimonial: t),
                          ),
                        ),
                      if (slice.length < _itemsPerPage)
                        for (int i = 0;
                        i < _itemsPerPage - slice.length;
                        i++)
                          const Expanded(child: SizedBox()),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 dots + arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: _currentPage > 0 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    boxShadow: _currentPage > 0
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: IconButton(
                    onPressed: _currentPage > 0
                        ? () => _goToPage(_currentPage - 1)
                        : null,
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      color: Color(0xFF165DFC),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: List.generate(_pageCount, (i) {
                    final active = i == _currentPage;
                    return GestureDetector(
                      onTap: () => _goToPage(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 32 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFF165DFC)
                              : const Color(0xFFD1D5DB),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: _currentPage < _pageCount - 1
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    boxShadow: _currentPage < _pageCount - 1
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: IconButton(
                    onPressed: _currentPage < _pageCount - 1
                        ? () => _goToPage(_currentPage + 1)
                        : null,
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF165DFC),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}


class _AvatarWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final Color backgroundColor;

  const _AvatarWidget({
    required this.imagePath,
    required this.name,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: backgroundColor,
      child: Image.asset(
        imagePath,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  Color _getAvatarColor(String name) {
    final colors = [
      const Color(0xFF165DFC),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFF06B6D4),
    ];
    final index = name.isNotEmpty ? name.codeUnitAt(0) % colors.length : 0;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // stars
          Row(
            children: List.generate(5, (index) {
              final filled = index < testimonial.rating;
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  Icons.star_rounded,
                  size: 20,
                  color:
                  filled ? const Color(0xFFFFB020) : const Color(0xFFE5E7EB),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          // text
          Text(
            testimonial.text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF374151),
              height: 1.6,
              letterSpacing: -0.2,
            ),
          ),

          const SizedBox(height: 24),

          // header: avatar + name + role
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 2,
                  ),
                ),
                child: _AvatarWidget(
                  imagePath: testimonial.avatar,
                  name: testimonial.name,
                  backgroundColor: _getAvatarColor(testimonial.name),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      testimonial.role,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Testimonial {
  final String name;
  final String role;
  final String avatar;
  final int rating; // 0–5
  final String text;

  Testimonial({
    required this.name,
    required this.role,
    required this.avatar,
    required this.rating,
    required this.text,
  });
}

final _dummyTestimonials = <Testimonial>[
  Testimonial(
    name: "Leo",
    role: "Lead Designer",
    avatar: 'assets/images/avatar_leo.png',
    rating: 4,
    text:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus nibh mauris, nec turpis orci lectus maecenas. Suspendisse sed magna eget nibh in turpis.",
  ),
  Testimonial(
    name: "Sofia",
    role: "Product Manager",
    avatar: 'assets/images/avatar_sofia.png',
    rating: 5,
    text:
    "Consequat duis diam lacus arcu. Faucibus venenatis felis id augue sit cursus pellentesque enim arcu. Elementum felis magna pretium in tincidunt.",
  ),
  Testimonial(
    name: "James",
    role: "CEO, StartupX",
    avatar: 'assets/images/avatar_james.png',
    rating: 5,
    text:
    "Suspendisse sed magna eget nibh in turpis. Consequat duis diam lacus arcu. Faucibus venenatis felis id augue sit cursus pellentesque.",
  ),
  Testimonial(
    name: "Ayesha",
    role: "Marketing Lead",
    avatar: 'assets/images/avatar_ayesha.png',
    rating: 4,
    text:
    "Cursus nibh mauris, nec turpis orci lectus maecenas. Suspendisse sed magna eget nibh in turpis. Consequat duis diam lacus arcu.",
  ),
  Testimonial(
    name: "Hassan",
    role: "CTO, DigitalCo",
    avatar: 'assets/images/avatar_hassan.png',
    rating: 5,
    text:
    "Elementum felis magna pretium in tincidunt. Suspendisse sed magna eget nibh in turpis. Consequat duis diam lacus arcu.",
  ),
];
