import 'package:digify_app/core/extensions/colors.dart';
import 'package:digify_app/core/extensions/textstyles.dart';
import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tab1Title,
    required this.tab2Title,
     this.tabController,
    this.padding,
  });

  final String tab1Title;
  final String tab2Title;
  final EdgeInsets? padding;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: context.blackColor.withAlpha(26)),
          boxShadow: [
            BoxShadow(
              color: context.blackColor.withAlpha(15),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: PreferredSize(
          preferredSize: Size.fromHeight(31), // Adjust height here

          child: TabBar(
            controller: tabController,
            indicatorPadding: EdgeInsets.all(4),
            // Space around the active tab
            indicatorSize: TabBarIndicatorSize.tab,

            // Makes selected tab indicator wider
            padding: EdgeInsets.zero,
            indicator: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25.5),
                  child: Text(tab1Title, style: context.text14SemiBold),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25.5),
                  child: Text(tab2Title, style: context.text14SemiBold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
