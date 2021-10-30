import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:project_v/Resources/sizeConfig.dart';
import 'package:project_v/Widgets/widgets.dart';
import 'package:project_v/screens/emails.dart';
import 'package:provider/provider.dart';

import 'Resources/language.dart';
import 'Resources/provider.dart';
import 'Resources/vICons.dart';
import 'package:project_v/Resources/section.dart';

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
              locale: Locale('ar', ''),
              supportedLocales: [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              localizationsDelegates: [
                AppLocal.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: AnimationOnly(),
              theme: ThemeData(
                fontFamily: "Aljazeera"
              ),
              // theme: theme.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
            );
          });
      });
    });
  }
}

class AnimationOnly extends StatefulWidget {
  const AnimationOnly({Key? key}) : super(key: key);

  @override
  _AnimationOnlyState createState() => _AnimationOnlyState();
}

class _AnimationOnlyState extends State<AnimationOnly> with TickerProviderStateMixin{
  bool show = true;
  bool finishLines = false;

  ScrollController scrollController = ScrollController();
  late AnimationController controller = AnimationController(vsync: this)..addListener((){
    setState(() {
    controller.value <= 0.3 ? show = false : show = true;
    if(controller.value >= 0.5){
      lines.forward();
    }
  });});
  late AnimationController lines = AnimationController(vsync: this)..addListener((){
    setState(() {
      lines.value >= 0.5? finishLines = true : finishLines = false;
    });});
  late AnimationController goingOut = AnimationController(vsync: this)..addListener(() {setState(() {});});
  late PageController pageController = PageController(viewportFraction: 0.8453333)..addListener(() async{
    if(pageController.offset % (SizeConfig.screenWidth * 0.8453333) == 0.0){
      await goingOut.forward();
      await controller.forward();
      goingOut.reset();

    }else{
      controller.reset();
      goingOut.reset();
      lines.reset();
    }
  });


  @override
  Widget build(BuildContext context) {
    final function = Provider.of<Functions>(context);
    double cardWidth = SizeConfig.screenWidth - (SizeConfig.widthMultiply * 24);

    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Image.asset("images/BG${sections[function.currentPage]["img"]}.png", width: SizeConfig.screenWidth, fit: BoxFit.fitWidth,),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth,
                  height: 217 * SizeConfig.heightMultiply,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: show ? 1.0 : 0.0,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Lottie.asset(
                            'images/pyramid.json',
                            repeat: false,
                            controller: controller,
                            onLoaded: (comp){
                              controller.. duration = comp.duration ..forward();
                            }
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: !show ? 1.0 : 0.0,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Lottie.asset(
                            'images/dipping pyramid.json',
                            repeat: false,
                            controller: goingOut,
                            onLoaded: (comp){
                              goingOut.. duration = comp.duration;
                            }
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: show ? 1.0 : 0.0,
                        child: Container(
                          alignment: Alignment(-1.0, 1.0),
                          child: Lottie.asset(
                            'images/base stroke.json',
                            repeat: false,
                            controller: lines,
                            onLoaded: (comp){
                              lines.. duration = comp.duration;
                            }
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: show ? 1.0 : 0.0,
                        child: Container(
                          margin: EdgeInsets.only(right: SizeConfig.widthMultiply * 10),
                          alignment: Alignment(1.0, 1.0),
                          child: function.fst == '' ? Container() : Lottie.asset(
                            'images/upper stroke.json',
                            repeat: false,
                            controller: lines,
                            onLoaded: (comp){
                              lines.. duration = comp.duration;
                            }
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment(-0.95,0.4),
                        child: Opacity(
                          opacity: finishLines ? 1.0 : 0.0,
                          child: Container(
                            child: Text(
                              function.snd,
                              style: TextStyle(
                                fontFamily: "Arabic",
                                fontWeight: FontWeight.w700,
                                fontSize: 14 * SizeConfig.textMultiply,
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment(0.7,-0.1),
                        child: Opacity(
                          opacity: finishLines ? 1.0 : 0.0,
                          child: Container(
                            child: Text(
                              function.fst,
                              style: TextStyle(
                                fontFamily: "Arabic",
                                fontWeight: FontWeight.w700,
                                fontSize: 14 * SizeConfig.textMultiply,
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: SizeConfig.heightMultiply * 66, bottom: SizeConfig.heightMultiply * 14, start: SizeConfig.widthMultiply * 30),
                  child: Text(
                    'اختر مسارك:',
                    style: TextStyle(
                      fontFamily: "Arabic",
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.textMultiply * 24
                    ),
                  ),
                ),
                Expanded(
                    child: PageView.builder(
                        itemCount: sections.length,
                        controller: pageController..addListener(() {function.changedStudentHomePageControllerValue(pageController.page!, controller);}),
                        onPageChanged: (page){
                          function.changeStudentCurrentPage(page);
                        },
                        itemBuilder: (context, index) {
                          function.addScroll();


                          final controller = function.animationScrollControllers[index];
                          Map<String, dynamic> current = sections[index];

                          double controllerValue = ((function.studentHomePageControllerValue * 100).floor() / 100 );
                          double fr = controllerValue % 1;
                          double sc = 1- (controllerValue % 1);


                          double condition = fr;
                          double condition2 = 0.5;

                          double visible = (0.6 * (condition <= condition2 ? fr : sc ) );
                          double hidden = (0.6 * (condition <= condition2 ? sc : fr ) );

                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(SizeConfig.widthMultiply * 25 * (index == function.currentPage ? visible : hidden)),
                            child: FittedBox(
                              child: Container(
                                height: SizeConfig.heightMultiply * 378,
                                // width: SizeConfig.widthMultiply * 305,
                                width: cardWidth,
                                child: FrostedGlass(
                                  height: 378,
                                  // width: 305,
                                  width: SizeConfig.screenWidth,
                                  color: "0xFFFFFFFF",
                                  colorOp: 0.7 - (index == function.currentPage ? visible : hidden),
                                  borderRadius: 16,
                                  blur: 10,
                                  child: Container(
                                    height: SizeConfig.heightMultiply * 378,
                                    // width: SizeConfig.widthMultiply * 305,
                                    width: cardWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeConfig.widthMultiply * 16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: cardWidth,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(top: SizeConfig.heightMultiply * 20),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiply * 9),
                                            height: SizeConfig.widthMultiply * 50,
                                            width: SizeConfig.widthMultiply * 50,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(SizeConfig.widthMultiply * 9),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0,2),
                                                  blurRadius: 19,
                                                  color: Colors.black.withOpacity(0.5),
                                                )
                                              ]
                                            ),
                                            child: Image.asset('images/${current["img"]}.png'),
                                          ),
                                        ),
                                        Container(
                                          width: cardWidth,
                                          alignment: Alignment.center,
                                          child: Text(
                                            current['title'],
                                            style: TextStyle(
                                              fontFamily: "Arabic",
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig.textMultiply * 32
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiply * 7,),
                                        Container(
                                          width: cardWidth,
                                          alignment: Alignment.center,
                                          child: Text(
                                            current['subTitle'],
                                            style: TextStyle(
                                              fontFamily: "Arabic",
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig.textMultiply * 18
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.heightMultiply * 10,),
                                        Container(
                                          width: SizeConfig.widthMultiply * 300,
                                          height: SizeConfig.heightMultiply * 130,
                                          margin: EdgeInsets.only(right: SizeConfig.widthMultiply * 18),
                                          child: ListView(
                                            controller: controller,
                                            physics: controller.hasClients ? controller.position.maxScrollExtent <= 0 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics() : BouncingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            children: [
                                              Text(
                                                current['dec'],
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                  fontFamily: "Arabic",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig.textMultiply * 15.5
                                                ),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(bottom: SizeConfig.heightMultiply * 21),
                                          width: cardWidth,
                                          padding: EdgeInsets.only(left: SizeConfig.widthMultiply * 14, right: SizeConfig.widthMultiply * 18),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "مده المسار",
                                                    style: TextStyle(
                                                        fontFamily: "Arabic",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: SizeConfig.textMultiply * 16
                                                    ),
                                                  ),
                                                  Text(
                                                    current["time"],
                                                    style: TextStyle(
                                                        fontFamily: "Arabic",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: SizeConfig.textMultiply * 14
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "مواصفات الجهاز",
                                                    style: TextStyle(
                                                        fontFamily: "Arabic",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: SizeConfig.textMultiply * 16
                                                    ),
                                                  ),
                                                  Text(
                                                    current["device"],
                                                    style: TextStyle(
                                                        fontFamily: "Arabic",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: SizeConfig.textMultiply * 14
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                ),

                Container(
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(bottom: SizeConfig.heightMultiply * 43, top: 23),
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.heightMultiply * 42,
                    width: SizeConfig.widthMultiply * 305,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEC400),
                      borderRadius: BorderRadius.circular(SizeConfig.widthMultiply * 4),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    child: Text(
                      "التالي",
                      style: TextStyle(
                          fontFamily: "Arabic",
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.textMultiply * 18
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

