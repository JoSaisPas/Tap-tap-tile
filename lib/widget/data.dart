

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

enum StyleButton {classic, glass}

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