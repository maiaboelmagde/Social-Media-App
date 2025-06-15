import 'package:flutter/material.dart';
import 'package:social_media_app/core/extensions/extensions.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/auth/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userEmailController = TextEditingController();
  final _userPaswordController = TextEditingController();

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
                  'Sign In',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),                
                SizedBox(height: 40),
                TextFormField(
                  controller: _userEmailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'user email is required ..';
                    } else if (!value.isValidEmail) {
                      return 'Invalid email !!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    label: Text('Enter your email'),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  obscureText: true,

                  controller: _userPaswordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'password is required ..';
                    } else if (!value.isValidPassword) {
                      return 'Invalid pasword, should be more than 8 letters, contains upper/lower/special letters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    label: Text('enter password ..'),
                  ),
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // UserModel.setUserModel(
                        //   _userNameController.value.text,
                        //   _userEmailController.text,
                        //   _userPaswordController.text,
                        // );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SignInScreen(),
                        //   ),
                        // );
                      }
                    },
                    child: Text('sign In'),
                  ),
                ),
                Row(
                  children: [
                    Text("You Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    }, child: Text('Sign up'))
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
