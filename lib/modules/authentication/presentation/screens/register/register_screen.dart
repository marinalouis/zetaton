import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/components/custom_text_field.dart';

import 'package:zetaton/core/util/app_integer.dart';

import 'package:zetaton/modules/authentication/presentation/controllers/register_provider.dart';
import 'package:zetaton/core/util/app_strings.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.registerPage),
        ),
        body: Padding(
          padding: defaultPaddingOfViews,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller:
                    context.read<RegisterViewModel>().firstNameController,
                label: AppStrings.firstNameLabelText,
              ),
              CustomTextField(
                controller:
                    context.read<RegisterViewModel>().lastNameController,
                label: AppStrings.lastNameLabelText,
              ),
              CustomTextField(
                controller: context.read<RegisterViewModel>().emailController,
                label: AppStrings.loginPageEmailLabelText,
              ),
              CustomTextField(
                controller:
                    context.read<RegisterViewModel>().passwordController,
                obscure: true,
                label: AppStrings.loginPagePasswordButtonText,
              ),
              TextField(
                controller:
                    context.read<RegisterViewModel>().phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration:
                    const InputDecoration(labelText: AppStrings.phoneNumberLabelText),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  context.read<RegisterViewModel>().signup(context);
                },
                child: const Text(AppStrings.siginUpText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
