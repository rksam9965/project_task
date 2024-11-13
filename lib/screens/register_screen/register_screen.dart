import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth_screen.dart';
import '../../utils/colors.dart';
import '../../widgets/TextField.dart';


class RegisterForm extends StatefulWidget {
  final bool? tech;
  final bool? update;

  RegisterForm({super.key, this.tech, this.update});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();
    // String role = 'users'; // Example role input: "viewer" or "editor"
    // String username = 'test';

    // Register the user
    User? user = await _authService.registerUser(email, password);
    if (user != null) {
      // Show success dialog
      _showSuccessDialog();
    } else {
      _showErrorDialog("Registration failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: appBackGroundColor,
        // floatingActionButton: _buildFloatingActionButton(screenHeight, screenWidth),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: textHeadingColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField("Email", _emailController),
                  const SizedBox(height: 10),
                  _buildTextField("Password", _passwordController),
                  const SizedBox(height: 32),
                  _buildRegisterButton(screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildRegisterButton(double screenWidth) {
    return GestureDetector(
      onTap: _signUp,
      child: Container(
        decoration: BoxDecoration(
          color: floatingButtonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        width: screenWidth,
        height: 64,
        child: const Center(
          child: Text(
            'REGISTER',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('You have successfully registered!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);  // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);  // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      height: 64,
      child: CustomTextField(
        lable: label,
        controller: controller,
      ),
    );
  }
}
