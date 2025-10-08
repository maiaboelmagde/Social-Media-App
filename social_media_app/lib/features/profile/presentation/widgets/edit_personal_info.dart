import 'package:flutter/material.dart';

class EditUserDetails extends StatelessWidget {
  EditUserDetails({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile saved successfully!')),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Save Changes'),
            ),
          ),
        ),
      ),
    );
  }
}
