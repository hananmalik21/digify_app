import 'dart:developer';
import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:digify_app/features/common_widgets/inputfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async' as async;


class CustomDropdown<T> extends StatefulWidget {
  final String title;
  final String hintText;
  final String searchHintText;
  final List<T> options;
  final bool isEnable;
  final bool isLoadingMore;
  final bool showSearch;
  final bool searchLoading;
  final ValueChanged<T> onSelect;
  final TextEditingController controller;
  final TextEditingController searchController;
  final String Function(T) displayField;
  final Function(String val)? onSearch;
  final Function(String val)? pagination;

  const CustomDropdown({
    super.key,
    required this.title,
    this.isEnable = false,
    required this.hintText,
    this.showSearch = true,
    required this.searchHintText,
    required this.options,
    required this.onSelect,
    required this.controller,
    required this.searchLoading,
    required this.searchController,
    required this.displayField,
    this.onSearch,
    this.pagination,
    required this.isLoadingMore,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  bool isDropdownOpen = false;
  async.Timer? _debounce;

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          widget.searchLoading == false) {
        log("Reached end of list");
        if (widget.pagination != null) {
          widget.pagination!(widget.searchController.text);
        }
        // or create a separate `onPaginate` function
      }
    });
  }

  void _onSearchChanged(String text) {
    _debounce?.cancel();
    _debounce = async.Timer(const Duration(milliseconds: 500), () {
      if (widget.onSearch != null) {
        widget.onSearch!(text);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  void selectItem(T option) {
    final displayText = widget.displayField(option);
    setState(() {
      widget.controller.text = displayText;
      widget.onSelect(option);
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: InputFieldWidget(
            title: widget.title,
            hint: widget.controller.text.isNotEmpty
                ? widget.controller.text
                : widget.hintText,
            enable: widget.isEnable,
            controller: widget.controller,
            suffixWidget: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: toggleDropdown,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: AnimatedRotation(
                  turns: isDropdownOpen ? 0.5 : 0,
                  duration: Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    height: 10,
                    width: 10,
                    'assets/images/arrow_down.svg',
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isDropdownOpen
              ? Container(
                  constraints: BoxConstraints(minHeight: 56, maxHeight: 300),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.showSearch) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: InputFieldWidget(
                              controller: widget.searchController,
                              prefixIcon: Icons.search,
                              hint: widget.searchHintText,
                              onChange: _onSearchChanged,
                            ),
                            // TextField(
                            //   controller: widget.searchController,
                            //   decoration: InputDecoration(
                            //     hintText: widget.searchHintText,
                            //     border: InputBorder.none,
                            //     prefixIcon: Icon(Icons.search, size: 20),
                            //   ),
                            //   onChanged: _onSearchChanged,
                            // ),
                          ),
                          Divider(height: 1, color: Colors.grey.shade300),
                        ],
                        // if (filteredOptions.isNotEmpty)
                        if (widget.searchLoading)
                          Expanded(
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.all(20),
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        else if (widget.options.isNotEmpty)
                          Flexible(
                            child: ListView(
                              controller: scrollController,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              children: widget.options.map((option) {
                                final displayText = widget.displayField(option);
                                return GestureDetector(
                                  onTap: () => selectItem(option),
                                  child: buildOption(
                                    displayText,
                                    isSelected:
                                        displayText == widget.controller.text,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "No results found.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        if (widget.isLoadingMore)
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget buildOption(String text, {bool isSelected = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected
            ? context.primaryColor
            : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(isSelected ? 12 : 0),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: context.text14SemiBold.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
