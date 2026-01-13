import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_text.dart';

class InputFieldWidget extends ConsumerStatefulWidget {
  final String? hint;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String value)? onChange;
  final IconData? prefixIcon;
  final String? prefixImage;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final bool obscure;
  final bool enable;
  final bool textAlignCenter;
  final bool isSvg;
  final bool showPadding;
  final bool showPaddingForSearch;
  final String? label;
  final bool showDropArrow;
  final bool showBorder;
  final bool isFill;
  final bool showUnderLineBorder;
  final Widget? suffixWidget;
  final bool showObscureByText;
  final int? maxLength;
  final bool isCoupon;
  final FormFieldValidator<String?>? validator; // add this line
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixWidget;
  final Color? borderColor;
  final String? buttonText;
  final double borderRadius;
  final double textFieldHeight;
  final void Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final String? title;
  final Color? fillColor;

  const InputFieldWidget({
    super.key,
    this.focusNode,
    this.hint,
    this.prefixIcon,
    this.prefixImage,
    this.controller,
    this.textFieldHeight = 56,
    this.maxLines = 1,
    this.minLines=1,
    this.isCoupon = false,
    this.onTap,
    this.buttonText = '',
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.enable = true,
    this.textAlignCenter = false,
    this.onChange,
    this.isSvg = false,
    this.showPaddingForSearch = false,
    this.showPadding = false,
    this.label,
    this.showDropArrow = false,
    this.showBorder = true,
    this.isFill = false,
    this.showUnderLineBorder = false,
    this.suffixWidget,
    this.showObscureByText = false,
    this.validator,
    this.inputFormatter,
    this.maxLength,
    this.prefixWidget,
    this.borderColor,
    this.onFieldSubmitted,
    this.fillColor,
    this.textInputAction,
    this.borderRadius = 6,
    this.title,
  });

  @override
  InputFieldWidgetState createState() => InputFieldWidgetState();
}

class InputFieldWidgetState extends ConsumerState<InputFieldWidget> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: widget.title ?? "",
                textStyle: context.text12Medium.copyWith(fontSize: 14.sp)),
          ),
          if (widget.title != null) 8.verticalSpace,
          TextFormField(
            focusNode: widget.focusNode,
            cursorColor: Theme.of(context).primaryColor,
            style: widget.enable
                ? context.text14Regular
                : context.text14Regular,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onChange,
            validator: widget.validator,
            enabled: widget.enable,
            controller: widget.controller,
            minLines: widget.minLines,
            onFieldSubmitted: widget.onFieldSubmitted,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlignCenter == true
                ? TextAlign.center
                : TextAlign.start,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatter,

            // : widget.inputFormatter,
            textAlignVertical: TextAlignVertical.center,
            obscureText: widget.obscure ? obscure : widget.obscure,
            decoration: InputDecoration(
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.start,

              counter: const Offstage(),
              labelText: widget.label,
              contentPadding: widget.showPadding
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
                  : widget.showPaddingForSearch
                      ? const EdgeInsets.only(right: 20, left: 20)
                      : const EdgeInsets.only(right: 20, left: 16),
              hintStyle: context.text14Regular.copyWith(color: context.gray99TextColor),
              // labelStyle: Theme.of(context).textTheme.headlineLarge,
              filled: true,
              fillColor:  widget.fillColor??context.textFieldColor,
              border: buildUnderlineInputBorder(
                  context: context,
                  color: widget.borderColor??Colors.transparent),
              enabledBorder: buildUnderlineInputBorder(

                  context: context,
                  color: widget.borderColor??Colors.transparent),
              errorBorder: buildUnderlineInputBorder(
                  context: context,
                  color: context.errorColor),
              focusedBorder: buildFocusedInputBorder(context: context),
              disabledBorder: buildUnderlineInputBorder(
                  context: context,
                  color: Colors.transparent),
              focusedErrorBorder: buildUnderlineInputBorder(
                  context: context,
                  color: context.errorColor),
              prefixIconConstraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width * 0.5,
                maxWidth: MediaQuery.of(context).size.width * 0.5,
              ),
              prefixIcon: widget.prefixWidget ??
                  (widget.prefixIcon != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            widget.prefixIcon,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : widget.prefixImage != null
                          ? Container(
                              width: 17,
                              height: 17,
                              margin: const EdgeInsetsDirectional.only(
                                  start: 15, end: 10),
                              child: widget.isSvg
                                  ? SvgPicture.asset(
                                      widget.prefixImage!,
                                      colorFilter:  ColorFilter.mode(
                                          Theme.of(context).colorScheme.secondary,
                                          BlendMode.srcIn),
                                      width: 20,
                                    )
                                  : Image.asset(
                                      widget.prefixImage!,
                                      // color: ThemeType.themeGrayColor,
                                    ))
                          : null),
              // suffix: widget.suffixWidget,
              suffixIcon: widget.showObscureByText
                  ? widget.isCoupon == true
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 1,
                              height: 15,
                              color: const Color(0xffc1c1c1),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              onTap: widget.onTap,
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                        color: const Color(0xffc1c1c1))),
                                child: Text(widget.buttonText!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: Colors.white,
                                        )),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 1,
                                height: 15,
                                color: const Color(0xffc1c1c1),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                obscure ? "Show" : "Hide",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: const Color(0xff828282),
                                    ),
                              ),
                            ],
                          ))
                  : widget.suffixWidget ??
                      (widget.showDropArrow
                          ? const Icon(
                              Icons.arrow_drop_down_outlined,
                              // color: BaseTheme.lightThemeIconColor,
                            )
                          : !widget.obscure
                              ? null
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  child: obscure
                                      ?
                                  Container(
                                          width: 15,
                                          height: 15,
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  start: 14, end: 14),
                                          // child: SvgPicture.asset(
                                          //     Assets.images.hidePasswordIcon)
                                  )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Color(0xff828282),
                                          size: 23,
                                        ),
                                )),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder buildUnderlineInputBorder(
      {required BuildContext context, required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  InputBorder buildFocusedInputBorder({required BuildContext context}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: context.primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }
}
