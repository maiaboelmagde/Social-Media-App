import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/extensions/media_query_values.dart';
import 'package:social_media_app/features/profile/presentation/cubits/personal_info_cubit/personal_info_cubit.dart';

class EditUserDetails extends StatelessWidget {
  EditUserDetails({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Personal Info')),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: context.hp(0.04)),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.hp(0.04)),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: bioController,
                  decoration: InputDecoration(labelText: 'Bio'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.hp(0.2)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          sl<PersonalInfoCubit>().updatePersonalInfo(
                            userId: sl<FirebaseAuth>().currentUser!.uid,
                            name: nameController.text.trim(),
                            bio: bioController.text.trim(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile saved successfully!'),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save Changes'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
