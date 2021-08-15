import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_v/Resources/Color.dart';
import 'package:project_v/Resources/sizeConfig.dart';
import 'package:project_v/Resources/vICons.dart';
import 'package:project_v/screens/emails.dart';

import '../main.dart';

class VAppBar extends StatelessWidget {
  final bool haveNotification;
  final String title;
  const VAppBar({Key? key, this.haveNotification = false, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      // height: SizeConfig.heightMultiply * 26,
      margin: EdgeInsets.only(top: SizeConfig.heightMultiply * 38),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiply * 23),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: SizeConfig.widthMultiply * 23,
            child: FittedBox(
              child: Icon(VIcons.back),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.textMultiply * 30,
              color: Colors.black
            ),
          ),
          Container(
            width: SizeConfig.widthMultiply * 20,
            child: haveNotification ? Image.asset("images/haveNotification.png",fit: BoxFit.contain ) : FittedBox(
              child: Icon(VIcons.notification),
            ),
            // child: Image.asset("images/haveNotification.png", fit: BoxFit.contain,),
          ),
        ],
      ),
    );
  }
}

class NavICons extends StatelessWidget {
  final IconData icon;
  final bool active;
  final Function function;
  const NavICons({Key? key, required this.icon, this.active = false, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => function(),
      child: Container(
        width: SizeConfig.widthMultiply * 50,
        height: SizeConfig.heightMultiply * 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: active ? VColors.orange : Colors.transparent, width: 1)),
        ),
        child: Container(
          width: SizeConfig.widthMultiply * 25,
          child: FittedBox(
            child: Icon(icon, color: active ? VColors.orange : Colors.black,),
          ),
        ),
      ),
    );
  }
}


class NavBar extends StatelessWidget {
  final int active;
  const NavBar({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.heightMultiply * 54,
      decoration: BoxDecoration(
        color: VColors.whiteToBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(SizeConfig.heightMultiply * 10)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,0),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.25),
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Change the Class to the Page when it ready
          NavICons(icon: VIcons.person, function: active == 0 ? ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start() /* here */)): (){}, active: active == 0,),
          NavICons(icon: VIcons.rank, function: active == 1 ? ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start() /* here */)): (){}, active: active == 1,),
          NavICons(icon: VIcons.email, function: active == 2 ? ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationPage())): (){}, active: active == 2,),
          NavICons(icon: VIcons.system, function: active == 3 ? ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Start() /* here */)): (){}, active: active == 3,),
        ],
      ),
    );
  }
}


