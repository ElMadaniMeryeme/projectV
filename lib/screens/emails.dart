import 'package:flutter/material.dart';
import 'package:project_v/Resources/sizeConfig.dart';
import 'package:project_v/Widgets/widgets.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VAppBar(haveNotification: false,),
            VAppBar(haveNotification: true,),
            VAppBar(haveNotification: true, title: "title",),
            VAppBar(haveNotification: false, title: "title",),
            NavBar(active: 0,),
            NavBar(active: 1,),
            NavBar(active: 2,),
            NavBar(active: 3,),
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(active: 2,),
    );
  }
}
