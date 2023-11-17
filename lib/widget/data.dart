

import 'dart:ui';

import 'package:game/animated_background/models.dart';

enum Difficulty { easy, middle, hight }

int getDifficulty(Difficulty dif){
  switch(dif){
    case Difficulty.easy:
      return 3;
    case Difficulty.middle:
      return 4;
    case Difficulty.hight:
      return 5;
  }
}

enum StyleButton {classic, glass, neon}

enum BackgroundStyle {classic, bubble, crystal}

Modele getModel(BackgroundStyle style){
  switch (style){
    case BackgroundStyle.classic:
      return ParticuleEmpty();
    case BackgroundStyle.bubble:
      return ParticuleBubbles();
    case BackgroundStyle.crystal:
      return ParticuleCrystal();
  }
}

BackgroundStyle getBackgroundStyle(Modele modele){
  if(modele is ParticuleEmpty) return BackgroundStyle.classic;
  if(modele is ParticuleBubbles) return BackgroundStyle.bubble;
   return BackgroundStyle.crystal;
}

const colors = [

  Color(0xff000000),
  Color(0xff808080),
  Color(0xffC0C0C0),

  Color(0xffFF0000),
  Color(0xffC70039),
  Color(0xffA12626),

  Color(0xffFCF002),
  Color(0xffFCD700),
  Color(0xffFFAA00),

  Color(0xff00FF00),
  Color(0xff49F690),
  Color(0xff25993A),

  Color(0xff0000FF),
  Color(0xff176AF3),
  Color(0xff4EE6DF),
];