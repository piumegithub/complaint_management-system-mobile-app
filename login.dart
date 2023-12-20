import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled11/form-test.dart';
import 'package:untitled11/registration.dart';
import 'package:passwordfield/passwordfield.dart';
import 'auth_service.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Widget _buildUserNameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        hintText: 'User Name',
        border: OutlineInputBorder(),
      ),
      maxLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'User Name cannot be empty';
        }
        return null;
      },
      onSaved: (value) {},
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      controller: passwordController,
      color: Colors.blue,
      passwordConstraint: r'.*[@$#.*].*',

      border: PasswordBorder(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade100,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade100,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          BorderSide(width: 2, color: Colors.red.shade200),
        ),
      ),
      errorMessage:
      'must contain special character either . * @ # \$',
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Set the text to bold
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                _buildUserNameField(),
                SizedBox(
                  height: 20,
                ),
                _buildPasswordField(),
                SizedBox(
                  height: 20,
                ),

    Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: ElevatedButton(
    onPressed: () async {
    // Assume you have TextEditingController instances for username and password
    String username = usernameController.text;
    String password = passwordController.text;

    // Call the login method from your AuthService
    bool isLoggedIn = await authService.login(username, password);

    if (isLoggedIn) {
    // Navigate to the next screen if login is successful
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FormTest()),
    );
    } else {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
    },
      child: Text('Log In'),
    ),
    ),

                Text(
                  "Don't have an account",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
            SizedBox(height: 5), // Add some space between text and button
            TextButton(
              onPressed: () {
                // Navigate to the sign-up form
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.blue, // Text color
                backgroundColor: Colors.transparent, // Background color
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 16,
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
