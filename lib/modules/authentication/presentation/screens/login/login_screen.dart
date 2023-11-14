
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/components/custom_text_field.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/core/util/app_strings.dart';
import 'package:zetaton/modules/authentication/presentation/controllers/login_provider.dart';
import 'package:zetaton/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.loginPage),
      ),
      body: Padding(
        padding: defaultPaddingOfViews,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _emailController,
              label: AppStrings.loginPageEmailLabelText,
            ),
            CustomTextField(
              controller: _passwordController,
              label: AppStrings.loginPagePasswordLabelText,
              obscure: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String email = _emailController.text;
                final String password = _passwordController.text;

                context.read<AuthViewModel>().login(email, password, context);
              },
              child: const Text(AppStrings.loginPagePasswordButtonText),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.haveAccountQuestionText,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.REGISTER);
                  },
                  child: const Text(
                    AppStrings.createAccountText,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
