import 'package:flutter/material.dart';

import '../app_screens/userListScreen.dart';
import '../size_config.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  static const routeName = 'initializer';

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(builder: (context, orientation) {
          SizeConfig().init(context);
          return Builder(
              builder: (context) {
            return  UserListScreen();

            // return const Center(
            //   child: CircularProgressIndicator.adaptive(),
            // );
          });
        });
      },
    );
  }
}
