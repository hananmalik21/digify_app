import 'package:digify_app/core/utils/utils.dart';
import 'package:flutter/material.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F6FF),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: Utils.isMobile(context) ? 30 : 102,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 800;

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _LeftContactInfo(),
                    const SizedBox(height: 24),
                    const _RightContactForm(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 5,
                    child: _LeftContactInfo(),
                  ),
                  const SizedBox(width: 40),
                  const Expanded(
                    flex: 6,
                    child: _RightContactForm(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// LEFT SIDE – Text + contact details
class _LeftContactInfo extends StatelessWidget {
  const _LeftContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE1EAFF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            "Get in Touch",
            style: TextStyle(
              color: Color(0xFF165DFC),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          "Ready to start your next project? Contact us\n"
              "today for a free consultation",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),

        const Text(
          "Whether you need a website, mobile app, custom software, or\n"
              "digital marketing services, we're here to help bring your vision\n"
              "to life. Reach out to us and let's discuss how we can help your\n"
              "business grow.",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF4B5563),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),

        const _ContactItem(
          icon: Icons.email_outlined,
          text: "abc@gmail.com",
        ),
        const SizedBox(height: 16),
        const _ContactItem(
          icon: Icons.phone_outlined,
          text: "xxxxxxxxxx",
        ),
        const SizedBox(height: 16),
        const _ContactItem(
          icon: Icons.location_on_outlined,
          text: "4074 Ebert Summit Suite 375",
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF111827),
            ),
          ),
        ),
      ],
    );
  }
}

/// RIGHT SIDE – Card with form
class _RightContactForm extends StatefulWidget {
  const _RightContactForm();

  @override
  State<_RightContactForm> createState() => _RightContactFormState();
}

class _RightContactFormState extends State<_RightContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _countryController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _countryController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual API call
      // final response = await NetworkApi().post(
      //   url: ApiEndPoints.contactUrl,
      //   body: {
      //     'name': _nameController.text.trim(),
      //     'email': _emailController.text.trim(),
      //     'company': _companyController.text.trim(),
      //     'country': _countryController.text.trim(),
      //     'message': _messageController.text.trim(),
      //   },
      // );

      if (mounted) {
        // Show success dialog
        _showSuccessDialog();
        
        // Reset form
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _companyController.clear();
        _countryController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        Utils().showToast(
          'Failed to send message. Please try again.',
          success: false,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Message Sent!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Thank you for contacting us. We\'ll get back to you soon!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LabeledField(
              label: "Name",
              hint: "John Doe",
              controller: _nameController,
              validator: (value) => _validateRequired(value, 'Name'),
            ),
            const SizedBox(height: 14),
            _LabeledField(
              label: "Email Address",
              hint: "john@gmail.com",
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: _validateEmail,
            ),
            const SizedBox(height: 14),
            _LabeledField(
              label: "Company Name",
              hint: "Abc",
              controller: _companyController,
              validator: (value) => _validateRequired(value, 'Company Name'),
            ),
            const SizedBox(height: 14),
            _LabeledField(
              label: "Country",
              hint: "Abc",
              controller: _countryController,
              validator: (value) => _validateRequired(value, 'Country'),
            ),
            const SizedBox(height: 14),
            _LabeledField(
              label: "Message",
              hint: "Type...",
              maxLines: 4,
              controller: _messageController,
              validator: (value) => _validateRequired(value, 'Message'),
            ),
            const SizedBox(height: 24),

            // button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBackgroundColor: const Color(0xFF9CA3AF),
                ),
                onPressed: _isSubmitting ? null : _handleSubmit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Send Message",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const _LabeledField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFFEF4444),
            ),
          ),
        ),
      ],
    );
  }
}
