import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/auth/domain/use_case/register_use_case.dart';
import 'package:social_media_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:social_media_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:social_media_app/features/auth/validation_check.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _userEmailController = TextEditingController();

  final _userPasswordController = TextEditingController();
  final _userPasswordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () => ThemeController.toggleTheme(),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _userNameController,
                  validator: (value) => ValidationCheck.checkName(value),
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    label: Text('Enter your Name'),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _userEmailController,
                  validator: (value) => ValidationCheck.checkEmail(value),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    label: Text('Enter your email'),
                  ),
                ),
                SizedBox(height: 40),
                PasswordTextFormField(
                  userPasswordController: _userPasswordController,
                  validator: (value) => ValidationCheck.checkPassword(value),
                ),
                SizedBox(height: 40),
                PasswordTextFormField(
                  userPasswordController: _userPasswordConfirmController,
                  validator: (value) =>
                      ValidationCheck.checkPasswordCofirmation(
                        _userPasswordConfirmController.text,
                        _userPasswordController.text,
                      ),
                ),
                SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        bool isSuccess = await sl<RegisterUseCase>().call(
                          name: _userNameController.text,
                          email: _userEmailController.text,
                          password: _userPasswordController.text,
                        );
                        if (isSuccess) {
                          _userNameController.clear();
                          _userEmailController.clear();
                          _userPasswordController.clear();
                          _userPasswordConfirmController.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('sign up'),
                  ),
                ),
                Row(
                  children: [
                    Text('You already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
