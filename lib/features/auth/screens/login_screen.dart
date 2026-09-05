import 'package:auto_route/annotations.dart';
import 'package:cubit_template/features/auth/widgets/auth_form_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthFormView(initialMode: AuthMode.signIn, hideBack: true);
  }
}
