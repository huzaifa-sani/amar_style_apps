import 'package:core_kit/core_kit_internal.dart';
import 'package:cubit_template/config/color/app_color.dart';
import 'package:flutter/material.dart';

class AppScreenLayout extends StatelessWidget {
  const AppScreenLayout({
    required this.body,
    super.key,
    this.appBar,
    this.useSafeArea = true,
    this.padding,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final decoration = BoxDecoration(
      color: colors.background,
    );

    Widget content = Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: body,
    );

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: decoration,
        child: content,
      ),
    );
  }
}
