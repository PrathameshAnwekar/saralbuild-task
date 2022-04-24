import 'package:flutter/material.dart';
import 'package:task/app_screens/userListScreen.dart';
import 'package:task/widgets/initializer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget formFieldBuilder(fieldController, label, hint, error) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty || value != 'admin') {
            return error;
          }
          return null;
        },
        autofocus: false,
        controller: fieldController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple.shade100, width: 1.0),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(20)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 20),
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.purple.shade300,
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: const Text('Saralbuild Task App')),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                formFieldBuilder(
                    usernameController,
                    'Username',
                    'Please enter your username',
                    'Please enter a valid username'),
                formFieldBuilder(passwordController, 'Password',
                    'Enter your password', 'Password invalid'),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logging In')),
                        );
                        Navigator.pushReplacementNamed(
                            context, InitializerWidget.routeName);
                      }
                    },
                    child: const Text('LOG IN'))
              ],
            ),
          )),
    );
  }
}
