import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/services/toast_service.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_image_cubit/profile_image_cubit.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_image_cubit/profile_image_state.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, required this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        //log('From "ProfileImageWidget" Current ProfileImageState: $state');
        if (state is ProfileImageFailure) {
          // log(
          //   'From "ProfileImageWidget" Profile image update failed: ${state.errorMessage}',
          // );
          ToastService.showToast(
            'Profile image update failed: ${state.errorMessage}',
          );
        }

        return CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundImage: state is ProfileImageSuccess
              ? NetworkImage(state.imageUrl)
              : imageUrl != null
              ? NetworkImage(imageUrl!)
              : const AssetImage('assets/images/user.png') as ImageProvider,
          child: state is ProfileImageLoading
              ? const CircularProgressIndicator(strokeWidth: 2)
              : const PickImageIconWidget(),
        );
      },
    );
  }
}

class PickImageIconWidget extends StatelessWidget {
  const PickImageIconWidget({super.key});

  void _showImageSourceDialog({
    required BuildContext context,
    required Function(XFile file) selectedFile,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Select image from :',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);

                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 10),
                  Text('Gallery'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 10),
                  Text('Camera'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 60),
      child: GestureDetector(
        onTap: () {
          _showImageSourceDialog(
            context: context,
            selectedFile: (XFile file) async {
              //log('From "ProfileImageWidget" Selected file path: ${file.path}');
              context.read<ProfileImageCubit>().updateProfileImage(
                userId: sl<FirebaseAuth>().currentUser!.uid,
                imageFile: file,
              );
            },
          );
        },
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            border: BoxBorder.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(Icons.camera_alt_outlined, size: 26, color: Colors.black),
        ),
      ),
    );
  }
}
