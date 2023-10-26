
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'models.dart';

class MultipleParticules extends SingleChildRenderObjectWidget{

  final Modele modele;
  final TickerProvider vsync;
  const MultipleParticules({required this.modele, required this.vsync, super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMultipleParticule(modele : modele, vsync: vsync);
  }

  @override
  void updateRenderObject(BuildContext context, RenderMultipleParticule renderObject){
    renderObject..modele = modele;
  }

}

class RenderMultipleParticule extends RenderProxyBox{
   Modele _modele;
   TickerProvider _vsync;
  RenderMultipleParticule({required modele, required vsync}) : _vsync = vsync,_modele = modele{_modele.renderObject = this;}

  //void set modele(Modele modele) => _modele = modele;

   set modele(value) {
     assert(value != null);
     Modele oldBehaviour = _modele;
     _modele = value;
     _modele.renderObject = this;
     _modele.initFrom(oldBehaviour);
     //usefull ?
     //markNeedsLayout();
   }



  @override
  void performLayout(){
    //Update the child : avoid assert
    if (child != null) child!.layout(constraints, parentUsesSize: true);
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset){
    if(!_modele.initialized) _modele.init();
    Canvas canvas = context.canvas;
    _modele.paint(context, offset);
    canvas.translate(offset.dx, offset.dy);
    super.paint(context, offset);
  }

   int _lastTimeMs = 0;
  late Ticker _ticker;
  ///Definition du temps
  void _tick(Duration elapsed){
    if(!_modele.initialized) return ;
    double delta =  (elapsed.inMilliseconds / _lastTimeMs) /1000.0;
    _lastTimeMs = elapsed.inMilliseconds;
    if(_modele.tick()){markNeedsLayout();}
  }

  ///add timer
  @override
  void attach(PipelineOwner owner){
    _lastTimeMs = 0;
    _ticker = _vsync.createTicker(_tick);
    _ticker.start();
    super.attach(owner);
  }

  ///dispose timer
  @override
  void detach(){
    _ticker.dispose();
    super.detach();
  }
}

