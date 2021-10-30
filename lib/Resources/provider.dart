import 'package:flutter/cupertino.dart';
import 'package:project_v/Resources/section.dart';

class Functions with ChangeNotifier{
  double studentHomePageControllerValue = 0;
  int currentPage = 0;
  double currentDouble = 0.0;

  bool show = true;
  String fst = 'قاعده البيانات';
  String snd = 'تاسيس برمجي';

  void changedStudentHomePageControllerValue(value, controller){
    studentHomePageControllerValue = value;
    notifyListeners();
    if(controller.value <= 0.5){
      fst = sections[currentPage]['levels'][0];
      snd =  sections[currentPage]['levels'][1];
    }
    notifyListeners();
  }

  List<ScrollController> animationScrollControllers = [];

  void addScroll(){
    animationScrollControllers.add(ScrollController());
    // notifyListeners();
  }


  void resetScroll(){
    animationScrollControllers = [];
    // notifyListeners();
  }

  void changeStudentCurrentPage(value){
    currentPage = value;
  }
}