import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/extensions/media_query_values.dart';
import 'package:social_media_app/features/auth/domain/use_case/reset_password_usecase.dart';
import 'package:social_media_app/features/auth/validation_check.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: formKey,
        child: ListView(
          children: [
            SizedBox(height: context.hp(0.05)),
            TextFormField(
              controller: emailController,
              validator: (value) => ValidationCheck.checkEmail(value),
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                label: Text('Enter your email'),
              ),
            ),
            SizedBox(height: context.hp(0.3)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wp(0.1)),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    sl<ResetPasswordUsecase>().call(email: emailController.text);
                  }
                },
                child: Text('send reset email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
