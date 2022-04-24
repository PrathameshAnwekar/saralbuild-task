import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task/app_screens/newUserScreen.dart';

import '../size_config.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({Key? key}) : super(key: key);

  static const routeName = '/userListScreen';

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  var result;

  Future<String> getData() async {
    Response response =
        await get(Uri.parse('https://reqres.in/api/users?page=2'));
    result = jsonDecode(response.body);
    result = result['data'];
    print(result);
    return 'done';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List firstNames = [];
            List lastNames = [];
            List imageURLs = [];
            List emails = [];
            result.forEach((element) {
              firstNames.add(element['first_name']);
              lastNames.add(element['last_name']);
              imageURLs.add(element['avatar']);
              emails.add(element['email']);
            });

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: firstNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          tileColor: Colors.grey[900],
                          focusColor: Colors.grey[700],
                          leading: CircleAvatar(
                              radius: SizeConfig.screenWidth * 0.1,
                              backgroundImage: imageURLs[index] == null
                                  ? AssetImage('assets/genericProfilePic.jpeg')
                                      as ImageProvider
                                  : NetworkImage(imageURLs[index])),
                          subtitle: Text('${emails[index]}', style: TextStyle(color: Colors.white),),
                          trailing: Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    delete(Uri.parse(
                                        'https://reqres.in/api/users/$index'));
                                    setState(() {});
                                  },
                                  icon:
                                      Icon(Icons.delete, color: Colors.white)),
                            ]),
                          ),
                          title: Text(
                            '${firstNames[index]} ${lastNames[index]}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(NewUserScreen.routeName);
        },
      ),
    );
  }
}
