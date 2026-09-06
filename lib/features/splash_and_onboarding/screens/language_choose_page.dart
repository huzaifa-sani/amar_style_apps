import 'package:auto_route/annotations.dart';
import 'package:core_kit/core_kit_internal.dart';
import 'package:cubit_template/config/route/app_router.dart';
import 'package:cubit_template/config/route/app_router.gr.dart';
import 'package:cubit_template/features/splash_and_onboarding/widgets/language_item_widget.dart';
import 'package:flutter/material.dart';
import '../../../common_dialog/widgets/app_screen_layout.dart';

@RoutePage()
class LanguageChoosePage extends StatefulWidget {
  const LanguageChoosePage({super.key});

  @override
  State<LanguageChoosePage> createState() => _LanguageChoosePageState();
}

class _LanguageChoosePageState extends State<LanguageChoosePage> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return AppScreenLayout(
      body: Column(
        children: [
          60.height,
          // Language Icon
          Center(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.w),
                border: Border.all(color: Colors.black.withValues(alpha: 0.1), width: 1),
              ),
              child: Image.asset(
                'assets/images/translation.png',
                width: 40.w,
                height: 40.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          32.height,
          // Title
          const CkText(
            text: 'Choose Language',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            textColor: Colors.black,
          ),
          60.height,
          // Language List
          LanguageItemWidget(
            title: 'English',
            subtitle: 'Continue in English',
            flagAsset: 'assets/images/english.png',
            isSelected: _selectedLang == 'en',
            onTap: () => setState(() => _selectedLang = 'en'),
          ),
          16.height,
          LanguageItemWidget(
            title: 'বাংলা',
            subtitle: 'বাংলায় চালিয়ে যান',
            flagAsset: 'assets/images/bangla.png',
            isSelected: _selectedLang == 'bn',
            onTap: () => setState(() => _selectedLang = 'bn'),
          ),

          const Spacer(),

          // Continue Button
          CkButton(
            borderWidth: 50,
            titleText: "Continue",
            onTap: () {
              appRouter.replace(const LoginRoute());
            },
          ),
          40.height,
        ],
      ),
    );
  }
}
