
import 'package:flutter/material.dart';

const offScreenTop = -2.0;

class Tile extends StatefulWidget{
  final Color color;
  final double width;
  final double height;
  final double pos;
   int speed;
  final Function onEnd;
  final Function onDestroy;
  Alignment alignment;
   int index;
   Tile({super.key,
    required this.color,
    required this.width,
    required this.height,
    required this.pos,
    required this.speed,
    required this.onEnd,
    required this.index,
    required this.onDestroy,
     this.alignment =  const Alignment(0,0),
  });

  @override
  State<Tile> createState() => _Tile();
}

class _Tile extends State<Tile> with TickerProviderStateMixin{
  late Animation<Alignment> animation;
  late AnimationController controller;
  bool isDroping = false;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.speed));

    widget.alignment =  Alignment(widget.pos.toDouble(), offScreenTop);
    animation = Tween(begin: widget.alignment, end:  Alignment(widget.pos.toDouble(), 1.5)).animate(controller);
    controller.addListener(() {widget.alignment = animation.value;});
    ///Let the tile fall !

    controller.forward().whenComplete(() => widget.onEnd());
  }

   @override
   void dispose(){
    controller.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context){
    widget.alignment = animation.value;
    return AnimatedBuilder(

      key: widget.key,
      builder: (context, child){
        return Align(
          alignment: animation.value,
          child: child,
        );
      }, animation: controller,
      child: InkWell(
        onTapDown: (even){
          widget.onDestroy(widget.key);
        },
        child: Material(
          elevation: 20.0,
          shadowColor: Colors.black,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: widget.color,
            child:  const Center(child: Text(''),),
          ),
        )
      ),
    );
  }
}
