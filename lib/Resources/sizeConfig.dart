import 'package:flutter/material.dart';

class SizeConfig{

  static late double textMultiply;
  static late double imageSizeMultiply;
  static late double heightMultiply;
  static late double widthMultiply;

  static late double screenWidth;
  static late double screenHeight;

  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockWidth;
  static late double _blockHeight;

  void init(BoxConstraints constraints, Orientation orientation){
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    screenHeight = _screenHeight;
    screenWidth = _screenWidth;

    _blockWidth = _screenWidth / 375;
    _blockHeight = _screenHeight / 812;

    textMultiply = _blockWidth;
    imageSizeMultiply = _blockWidth;
    widthMultiply = _blockWidth;
    heightMultiply = _blockHeight;

  }

}