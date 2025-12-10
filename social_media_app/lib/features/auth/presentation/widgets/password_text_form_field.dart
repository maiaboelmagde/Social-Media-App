import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required TextEditingController userPasswordController,
    required String? Function(String?) validator,
    FocusNode? focusNode,
    void Function(String?)? onFieldSubmitted,
  }) : _userPasswordController = userPasswordController,
       _validator = validator,
       _focusNode = focusNode,
       _onFieldSubmitted = onFieldSubmitted;

  final TextEditingController _userPasswordController;
  final String? Function(String?) _validator;
  final FocusNode? _focusNode;
  final void Function(String?)? _onFieldSubmitted;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget._focusNode,
      onFieldSubmitted: widget._onFieldSubmitted,
      obscureText: obscure,
      controller: widget._userPasswordController,
      validator: widget._validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obscure
              ? Icon(Icons.remove_red_eye)
              : Icon(Icons.visibility_off),
          onPressed: () => setState(() {
            obscure = obscure ? false : true;
          }),
        ),
        icon: Icon(Icons.password),
        label: Text('enter password ..'),
      ),
    );
  }
}
