import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  void _showImageSourceDialog(
    BuildContext context,
    Function(XFile file) selectedFile,
  ) {
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
    return CircleAvatar(
      backgroundImage: AssetImage('assets/images/user.png'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      radius: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 60, top: 60),
        child: GestureDetector(
          onTap: () {
            _showImageSourceDialog(context, (XFile file) async {
              
            });
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
            child: Icon(
              Icons.camera_alt_outlined,
              size: 26,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
