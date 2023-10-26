import 'dart:math';
import 'package:flutter/material.dart';
import 'multiple_particules.dart';


/// My animated background is MAINLY inspired by the flutter_animated package
/// all credit goes to this package
/// pls check it out !!!
/// https://pub.dev/packages/animated_background/versions
abstract class Modele {


   Modele();

  bool get initialized;

  @protected
  RenderMultipleParticule? renderObject;

  @protected
  Size? get size => renderObject?.size;
  //Size? get size => Size(renderObject!.size.width, renderObject!.size.height + 350);

  @protected
  void paint(PaintingContext context, Offset offset);

  @protected
  void init();

  @protected
  void initFrom(Modele oldBehaviour);

  @protected
  bool tick();

  @protected
  void animation(Particule particule);

  @protected
  Widget builder(BuildContext context, BoxConstraints constraints, Widget child){
    return child;
  }
}


class Particule{
  double posX = 10.0;
  double posY = 10.0;
  double radius = 15.0;
  double saveRadius;
  Color color = Colors.red;
  bool bigger = true;
  double augmente = 0.0;
  double speed = 10.0;


  Particule({
    double x = 10.0,
    double y = 10.0,
    double r = 15.0,
    Color c = Colors.red,
    double a = 0.0,
    double s = 10.0,
  }) : posX = x, posY = y, radius = r, color = c, saveRadius = r, augmente = a, speed = s;

}


const List<Color> rainbow = [
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.pinkAccent
];

class ParticuleEmpty extends Modele{
   ParticuleEmpty();
  @override
  void animation(Particule particule) {
    // TODO: implement animation
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void initFrom(Modele oldBehaviour) {
    // TODO: implement initFrom
  }

  @override
  // TODO: implement initialized
  bool get initialized => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
  }

  @override
  bool tick() {
    return true;
  }

}
class ParticuleBubbles extends Modele{

  List<Particule>? particules;

  @override
  void animation(Particule particule) {
    particule.posY += -2.0;

  }

  @override
  void init() {
    particules = List.generate(50, (index) => addParticule());
  }

  Particule addParticule(){
    print(Random().nextInt(rainbow.length));
    return Particule(
        x: Random().nextDouble() * size!.width ,
        y: Random().nextDouble() * size!.height,
        r: (Random().nextDouble() * 25) + 10.0,
      //c: rainbow[Random().nextInt(rainbow.length)],

    );
  }

  @override
  void initFrom(Modele oldBehaviour) {
    if (oldBehaviour is ParticuleBubbles) {
      particules = oldBehaviour.particules;
    }
  }

  @override
  bool get initialized => particules != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if(particules == null) return;
    final Canvas canvas = context.canvas;


    for(Particule p in particules!){
      final Gradient gradient = RadialGradient(
          colors: [
            p.color.withOpacity(0.0),
            p.color.withOpacity(0.0),
            p.color.withOpacity(0.0),
            p.color.withOpacity(0.3),
            p.color.withOpacity(1.0),
          ]);

      final Paint paint = Paint()
        ..color = p.color
        ..strokeWidth = 1
        ..style = PaintingStyle.fill
        ..strokeJoin = StrokeJoin.round
      ..shader = gradient.createShader(Rect.fromCircle(center: Offset(p.posX, p.posY), radius: p.radius));
      canvas.drawCircle(Offset(p.posX, p.posY), p.radius, paint);
    }
  }

  @override
  bool tick() {
    if(particules == null) return false;
    Size other = Size(size!.width, size!.height + 50);
    for(Particule p in particules!){
      if(!other.contains(Offset(p.posX, p.posY))){
        p.posX = Random().nextDouble() * size!.width;
        p.posY =  size!.height ;
      }
      animation(p);
    }

    return true;
  }

}
class ParticuleCrystal extends Modele{
  List<Particule>? particules;


  @override
  void animation(Particule particule) {
    particule.posY += particule.speed;
  }

  @override
  void init() {
    particules = List.generate(25, (index) => addParticule());
  }

  Particule addParticule(){
    return Particule(
      // x : 200,
      //   y: 350,
      //   r: 350
        x: Random().nextDouble() * size!.width ,
        y: Random().nextDouble() * size!.height,
        r: getRadius(),
        s: (Random().nextDouble() * 8) + 2.0
    );
  }

  double getRadius(){
    return ((Random().nextInt(9)) + 1) % 9 == 0
        ? 350
        : (Random().nextDouble() * 150) + 10.0;
  }

  @override
  void initFrom(Modele oldBehaviour) {
    if (oldBehaviour is ParticuleCrystal) {
      particules = oldBehaviour.particules;
    }
  }

  @override
  bool get initialized =>  particules != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    if(particules == null) return;
    final Canvas canvas = context.canvas;

    for (Particule p in particules!){
      ///Apply de shader to all the screen
      var rect = Offset.zero & size!;

      ///Apply shader only to the shape
      var rect2 = Offset(p.posX, p.posY - p.radius) & Size(p.radius/2, p.radius);

      final Paint paint = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.fill
        ..strokeJoin = StrokeJoin.round
        ..shader =  const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Colors.cyanAccent, Colors.white, Colors.cyanAccent, Colors.cyan, Colors.lightBlueAccent]
        ).createShader(rect2);

      Path path = Path();
      path.moveTo(p.posX, p.posY);

      ///draw crystals from bottom to top !
      path.lineTo(p.posX - (p.radius/4), p.posY - (p.radius/2));
      path.lineTo(p.posX , p.posY - p.radius);
      path.lineTo(p.posX + (p.radius/4), p.posY - (p.radius/2));
      path.lineTo(p.posX , p.posY );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool tick() {
    if(particules == null) return false;
    ///Given a other size in order to let crystal disappear at the bottom
    Size other = Size(size!.width, size!.height + 350);
    for(Particule p in particules!){
      if(!other.contains(Offset(p.posX, p.posY))){
        p.posX = Random().nextDouble() * size!.width;
        p.posY =  0 ;
        p.radius = getRadius();
        p.speed= (Random().nextDouble() * 10) + 2.0;
      }
      animation(p);
    }
    return true;
  }

}

