import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:social_media_app/features/auth/data/repository/auth_repo_impl.dart';
import 'package:social_media_app/features/auth/domain/use_case/log_out_use_case.dart';
import 'package:social_media_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:social_media_app/features/profile/widgets/edit_personal_info.dart';
import 'package:social_media_app/features/profile/widgets/profile_image_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    children: [
                      ProfileImageWidget(),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
          
              Text('Profile Info',style: Theme.of(context).textTheme.displayMedium),
              ListTile(
                leading: Icon(Icons.person_2_outlined),
                title: Text('Personal Info'),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUserDetails()),
                ),
              ),
              Divider(),
              ValueListenableBuilder(
                valueListenable: ThemeController.themeNotifier,
                builder: (context, value, child) {
                  return ListTile(
                    leading: Icon(Icons.dark_mode_outlined),
                    title: Text('Dark mode'),
                    trailing: Switch(
                      activeColor: Colors.greenAccent,
                      value: ThemeController.isDark(),
                      onChanged: (value) {
                        ThemeController.toggleTheme();
                      },
                    ),
                    onTap: () {
                      ThemeController.toggleTheme();
                    },
                  );
                }
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log out'),
                trailing: Icon(Icons.navigate_next),
                onTap: () async {
                  LogOutUseCase(authRepo: AuthRepoImpl()).call();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
          
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}