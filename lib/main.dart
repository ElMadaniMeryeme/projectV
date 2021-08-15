import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v/Resources/sizeConfig.dart';
import 'package:project_v/Widgets/widgets.dart';
import 'package:project_v/screens/emails.dart';
import 'package:provider/provider.dart';

import 'Resources/provider.dart';
import 'Resources/vICons.dart';

void main(){
  runApp(Start());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return ChangeNotifierProvider(
            create: (context) => Functions(),
            builder: (context, _) {
              final function = Provider.of<Functions>(context);
              // ColorConfig().init(theme.isDark);
              // theme.isDark ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light) : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              return MaterialApp(
                home: NotificationPage(),
                // theme: theme.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
              );
            });
      });
    });
  }
}
