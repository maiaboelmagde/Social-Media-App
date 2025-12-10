import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_in_use_case.dart';
import 'package:social_media_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:social_media_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:social_media_app/features/auth/presentation/widgets/password_text_form_field.dart';
import 'package:social_media_app/features/auth/validation_check.dart';
import 'package:social_media_app/features/posts/presentation/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  void dispose() {
    focusEmail.dispose();
    focusPassword.dispose();
    super.dispose();
  }

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
                SizedBox(height: 120),
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 40),
                TextFormField(
                  focusNode: focusEmail,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(focusPassword);
                  },
                  textInputAction: TextInputAction.next,
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
                  focusNode: focusPassword,
                  onFieldSubmitted: (_) {},
                ),
                Row(
                  children: [
                    Text('Forgot password ?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text('Reset..'),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        bool isSuccess = await sl<LogInUseCase>().call(
                          email: _userEmailController.text,
                          password: _userPasswordController.text,
                        );
                        if (isSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('sign In'),
                  ),
                ),
                Row(
                  children: [
                    Text("You Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text('Sign up'),
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
