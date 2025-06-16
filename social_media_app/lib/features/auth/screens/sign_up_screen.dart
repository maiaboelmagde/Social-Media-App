import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/auth/screens/sign_in_screen.dart';
import 'package:social_media_app/features/auth/services/auth_service.dart';
import 'package:social_media_app/features/auth/validation_check.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userPasswordController = TextEditingController();

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
                  validator: (value) =>ValidationCheck.checkName(value),
                  decoration: InputDecoration(
                    icon: Icon(Icons.text_fields),
                    label: Text('Enter your Name'),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _userEmailController,
                  validator: (value) =>ValidationCheck.checkEmail(value),
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    label: Text('Enter your email'),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  obscureText: true,

                  controller: _userPasswordController,
                  validator: (value) =>ValidationCheck.checkPassword(value),
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    label: Text('enter password ..'),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  obscureText: true,
                  validator: (value) =>ValidationCheck.checkPasswordCofirmation(value, _userPasswordController.text),
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    label: Text('Password confirmation ..'),
                  ),
                ),
                SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        // UserModel.setUserModel(
                        //   _userNameController.value.text,
                        //   _userEmailController.text,
                        //   _userPaswordController.text,
                        // );
                        AuthService().registerUser(email: _userEmailController.text, password: _userPasswordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      }
                    },
                    child: Text('sign up'),
                  ),
                ),
                Row(
                  children: [
                    Text('You already have an account?'),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Sign in'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
