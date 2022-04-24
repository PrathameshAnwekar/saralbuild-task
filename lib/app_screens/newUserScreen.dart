import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:task/app_screens/userListScreen.dart';
import 'dart:convert';

import '../size_config.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);

  static const routeName = '/newUser';

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _formKey2 = GlobalKey<FormState>();

  final id = TextEditingController();
  final firstName = TextEditingController();
  final email = TextEditingController();

  final lastName = TextEditingController();

  var avatar;

  var imageFile;
  XFile? pickedFile;

  Future<http.Response> createNewUser() {
    var ans = http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': firstName.text,
        'last_name': lastName.text,
        'email': email.text
      }),
    );
    return ans;
  }

  void openGallery(BuildContext context) async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      print('something');
      imageFile = pickedFile!;
      print(imageFile.path);
    });
  }

  Widget formFieldBuilder(fieldController, label, hint, error) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
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
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done),
          onPressed: () async {
            if (_formKey2.currentState!.validate()) {
              await createNewUser();
              await Navigator.of(context)
                  .pushReplacementNamed(UserListScreen.routeName);
            }
          },
        ),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('Add a new user')),
        body: Form(
            key: _formKey2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      openGallery(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(SizeConfig.screenWidth * 0.05,
                          SizeConfig.screenHeight * 0.15, 0, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenWidth * 0.17),
                          border: Border.all(
                              color: Colors.grey.shade800,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: CircleAvatar(
                          radius: SizeConfig.screenWidth * 0.15,
                          backgroundImage: imageFile?.path == null
                              ? NetworkImage(
                                  'https://lh3.googleusercontent.com/2hDpuTi-0AMKvoZJGd-yKWvK4tKdQr_kLIpB_qSeMau2TNGCNidAosMEvrEXFO9G6tmlFlPQplpwiqirgrIPWnCKMvElaYgI-HiVvXc=w600')
                              : FileImage(File(imageFile?.path))
                                  as ImageProvider),
                    ),
                  ),
                  formFieldBuilder(firstName, 'First Name', '',
                      'Please enter your first name'),
                  formFieldBuilder(
                      lastName, 'Last Name', '', 'Please enter your last name'),
                  formFieldBuilder(
                      email, 'Email', '', 'Please enter a valid email ID')
                ],
              ),
            )),
      ),
    );
  }
}
