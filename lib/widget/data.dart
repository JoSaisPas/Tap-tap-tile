

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