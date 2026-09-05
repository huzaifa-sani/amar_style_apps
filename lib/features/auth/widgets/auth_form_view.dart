import 'package:core_kit/core_kit_internal.dart';
import 'package:cubit_template/config/color/app_color.dart';
import 'package:cubit_template/config/core_kit/core_kit_config.dart';
import 'package:cubit_template/features/auth/entity/auth_entity.dart';
import 'package:cubit_template/features/auth/entity/signup_entity.dart';
import 'package:flutter/material.dart';

import '../../../common_dialog/widgets/app_screen_layout.dart';
import '../../../common_dialog/widgets/forget_password_dialog.dart';

enum AuthMode { signIn, signUp }

class AuthFormView extends StatefulWidget {
  const AuthFormView({
    super.key,
    this.initialMode = AuthMode.signIn,
    this.hideBack = true,
  });

  final AuthMode initialMode;
  final bool hideBack;

  @override
  State<AuthFormView> createState() => _AuthFormViewState();

}

class _AuthFormViewState extends State<AuthFormView> {
  late AuthMode _mode;
  AuthEntity _authEntity = AuthEntity();
  SignUpEntity _signUpEntity = SignUpEntity();

  bool get _isSignIn => _mode == AuthMode.signIn;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  void _onModeChanged(AuthMode mode) {
    if (_mode == mode) return;
    setState(() {
      _mode = mode;
      _authEntity = AuthEntity();
      _signUpEntity = SignUpEntity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScreenLayout(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            20.height,
            Center(
              child: _AuthSlideSwitcher(
                mode: _mode,
                child: SizedBox(
                  key: ValueKey(_mode),
                  width: double.infinity,
                  child: _AuthHeader(
                    title: _isSignIn ? 'Welcome back' : 'Join Us Today',
                    subtitle: _isSignIn
                        ? 'Sign in to your account'
                        : 'Create a new account using our production-ready CoreKit modules.',
                  ),
                ),
              ),
            ),
            24.height,
            _AuthModeToggle(mode: _mode, onChanged: _onModeChanged),
            24.height,
            _AuthSlideSwitcher(
              mode: _mode,
              child: SizedBox(
                key: ValueKey(_mode),
                width: double.infinity,
                child: _isSignIn
                    ? _SignInForm(entity: _authEntity)
                    : _SignUpForm(entity: _signUpEntity),
              ),
            ),
            30.height,
          ],
        ),
      ),
    );
  }
}

class _AuthSlideSwitcher extends StatelessWidget {
  const _AuthSlideSwitcher({required this.mode, required this.child});

  final AuthMode mode;
  final Widget child;

  static const _duration = Duration(milliseconds: 340);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        duration: _duration,
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.hardEdge,
            children: [
              for (final previous in previousChildren)
                Positioned(top: 0, left: 0, right: 0, child: previous),
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (child, animation) {
          final toSignUp = mode == AuthMode.signUp;
          final childIsSignUp = child.key == const ValueKey(AuthMode.signUp);
          final isIncoming = toSignUp == childIsSignUp;
          final incomingFrom = toSignUp
              ? const Offset(1, 0)
              : const Offset(-1, 0);
          final outgoingTo = toSignUp
              ? const Offset(-1, 0)
              : const Offset(1, 0);

          return SlideTransition(
            position: Tween<Offset>(
              begin: isIncoming ? incomingFrom : outgoingTo,
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CkText(
          text: title,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          textColor: colors.tEXT_white,
          textAlign: TextAlign.left,
        ),
        8.height,
        CkText(
          text: subtitle,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textColor: colors.tEXT_subDark,
          textAlign: TextAlign.left,
          isDescription: true,
        ),
      ],
    );
  }
}

class _AuthModeToggle extends StatelessWidget {
  const _AuthModeToggle({required this.mode, required this.onChanged});

  final AuthMode mode;
  final ValueChanged<AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 48.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: colors.ratingPremiumTags_goldAccent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          _AuthModeTab(
            label: 'Sign In',
            selected: mode == AuthMode.signIn,
            onTap: () => onChanged(AuthMode.signIn),
          ),
          _AuthModeTab(
            label: 'Sign Up',
            selected: mode == AuthMode.signUp,
            onTap: () => onChanged(AuthMode.signUp),
          ),
        ],
      ),
    );
  }
}

class _AuthModeTab extends StatelessWidget {
  const _AuthModeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? colors.ratingPremiumTags_goldAccent
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: CkText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textColor: selected
                  ? colors.bACKGROUND_darkPage
                  : colors.tEXT_subDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.bACKGROUND_darkCard,
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(
          color: colors.bACKGROUND_darkCardBoarder,
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return CkText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      textColor: context.colors.tEXT_white,
      textAlign: TextAlign.left,
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({super.key, required this.entity});

  final AuthEntity entity;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return CkFormBuilder(
      entity: entity,
      builder: (_, formKey, formEntity) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _FieldLabel('Phone Number'),
            8.height,
            CkTextField(
              hintText: '+880 17',
              validationType: CkValidationType.validatePhone,
              onSaved: (value, controller) => formEntity.username = value,
            ),
            16.height,
            const _FieldLabel('Password'),
            8.height,
            CkTextField(
              hintText: 'Enter your password',
              validationType: CkValidationType.validatePassword,
              onChanged: (value) => formEntity.password = value,
            ),
            12.height,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  CkDialog(
                    context: context,
                    child: const ForgetPasswordDialogContent(),
                  );
                },
                child: CkText(
                  text: 'Forgot Password?',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: colors.ratingPremiumTags_goldAccent,
                ),
              ),
            ),
            30.height,
            ckAuth.loadingUi(
              type: CkAuthLoadingType.signIn,
              builder: (isLoading) {
                return CkButton(
                  titleText: 'Sign In',
                  isLoading: isLoading,
                  buttonRadius: 30.w,
                  titleWeight: FontWeight.w600,
                  buttonColor: colors.buttonBlack,
                  titleColor: Colors.white,
                  onTap: () {
                    if (formKey.validateAndSave()) {
                      ckAuth.signIn(
                        account: formEntity.username ?? '',
                        password: formEntity.password ?? '',
                      );
                    }
                  },
                );
              },
            ),
            30.height,
            // Divider with "or using"
            Row(
              children: [
                Expanded(child: Divider(color: colors.border_divider)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CkText(
                    text: 'or using',
                    fontSize: 12,
                    textColor: colors.tEXT_sub,
                  ),
                ),
                Expanded(child: Divider(color: colors.border_divider)),
              ],
            ),
            30.height,
            // Facebook Button
            _SocialButton(
              icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 28),
              label: 'Sign In with Facebook',
              onTap: () {},
            ),
            16.height,
            // Google Button
            _SocialButton(
              icon: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                width: 24,
                height: 24,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
              ),
              label: 'Sign In with Google',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF3F4F6),
        foregroundColor: Colors.black,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          12.width,
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({super.key, required this.entity});

  final SignUpEntity entity;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return CkFormBuilder(
      entity: entity,
      builder: (_, formKey, formEntity) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _FieldLabel('Username'),
            8.height,
            CkTextField(
              hintText: 'Choose a username',
              validationType: CkValidationType.validateUsername,
              onSaved: (value, controller) => formEntity.username = value,
            ),
            16.height,
            const _FieldLabel('Email Address'),
            8.height,
            CkTextField(
              hintText: 'Enter your email',
              validationType: CkValidationType.validateEmail,
              onSaved: (value, controller) => formEntity.email = value,
            ),
            16.height,
            const _FieldLabel('Password'),
            8.height,
            CkTextField(
              hintText: 'Create a password',
              validationType: CkValidationType.validatePassword,
              onChanged: (value) => formEntity.password = value,
            ),
            16.height,
            const _FieldLabel('Confirm Password'),
            8.height,
            CkTextField(
              hintText: 'Confirm Password',
              validationType: CkValidationType.validateConfirmPassword,
              originalPassword: () => formEntity.password ?? '',
            ),
            16.height,
            const _FieldLabel('Phone Number'),
            8.height,
            CkPhoneNumberTextField(
              textInputAction: TextInputAction.next,
              borderColor: colors.bACKGROUND_darkCardBoarder,
              initalCountryCode: 'US',
              countryChange: (phone) {
                formEntity.phoneNumber = phone.completeNumber;
              },
              onChanged: (phone) {
                formEntity.phoneNumber = phone.completeNumber;
              },
            ),
            30.height,
            ckAuth.loadingUi(
              type: CkAuthLoadingType.signUp,
              builder: (isLoading) {
                return CkButton(
                  titleText: 'Register',
                  isLoading: isLoading,
                  buttonRadius: 30.w,
                  titleWeight: FontWeight.w600,
                  buttonColor: colors.buttonBlack,
                  titleColor: Colors.white,
                  onTap: () {
                    if (formKey.validateAndSave()) {
                      ckAuth.signUp(
                        body: {
                          'username': formEntity.username ?? '',
                          'email': formEntity.email ?? '',
                          'password': formEntity.password ?? '',
                          'phone': formEntity.phoneNumber ?? '',
                          'dateOfBirth':
                              formEntity.dateOfBirth?.toIso8601String() ?? '',
                        },
                        loginCallback: LoginCallback(
                          account: formEntity.email ?? '',
                          password: formEntity.password ?? '',
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
