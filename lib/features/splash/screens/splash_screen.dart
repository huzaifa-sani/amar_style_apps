import 'package:auto_route/annotations.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:cubit_template/config/bloc/cubit_scope.dart';
import 'package:cubit_template/config/color/app_color.dart';
import 'package:cubit_template/features/splash/cubit/splash_cubit.dart';
import 'package:cubit_template/features/splash/widgets/splash_art.dart';
import 'package:flutter/material.dart';
import '../../../common_dialog/widgets/app_screen_layout.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppScreenLayout(
      useSafeArea: false,
      padding: EdgeInsets.zero,
      body: CubitScope(
        create: () => SplashCubit()..init(),
        builder: (context, cubit, state) {
          return Stack(
            children: [
              const SplashBackdrop(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AmarStyleLogo(height: 148.h),
                    28.height,
                    CkText(
                      text: 'AMAR STYLE',
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      textColor: colors.buttonBlack,
                      preventScaling: true,
                      style: const TextStyle(letterSpacing: 1.4),
                    ),
                    8.height,
                    CkText(
                      text: 'আমার স্টাইল',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: colors.tEXT_sub,
                      preventScaling: true,
                    ),
                    16.height,
                    CkText(
                      text: 'Find your salon. Choose your expert.',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      textColor: colors.tEXT_subDark,
                      preventScaling: true,
                      style: const TextStyle(letterSpacing: 0.2),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 72.h + MediaQuery.paddingOf(context).bottom,
                child: const Center(child: SplashPageIndicator()),
              ),
            ],
          );
        },
      ),
    );
  }
}
