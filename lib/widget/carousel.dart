


import 'package:flutter/material.dart';


class Carousel extends StatelessWidget{
  final Widget child;
  final Function(dynamic) onSelectedItemChange;
  final List list;
  const Carousel({
    super.key,
    required this.child,
    required this.onSelectedItemChange,
    required this.list,
  });

  @override
  Widget build(BuildContext context){
    return   Stack(
      children: [
        //Positioned.fill(child: child),
        child,
       Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
        child:ItemSelector(
          itemPerScreen: 3,
          padding: const EdgeInsets.all(2),
          list: list,
          callback: onSelectedItemChange,)
      ),
      ],
    );
  }
}

///Current selected item
class ItemSelector extends StatefulWidget{
  final  int? itemPerScreen;
  final EdgeInsets padding;
  final List list;
  final Function(dynamic) callback;
  const ItemSelector({
    super.key,
    required this.itemPerScreen,
    required this.padding,
    required this.list,
    required this.callback
  });

  @override
  State<ItemSelector> createState() => _ItemSelector();
}

class _ItemSelector extends State<ItemSelector>{
  late double _viewportFractionPerItem;
  late final PageController controller;
  late int page;
  @override
  void initState(){
    super.initState();
    _viewportFractionPerItem = 1.0 / widget.itemPerScreen!;
    page = 0;
    controller = PageController(initialPage: page, viewportFraction: _viewportFractionPerItem);
    controller.addListener(_onPagechanged);

    ///setup the controller's client
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {setState(() {

    }); });
  }

  void _onPagechanged(){
    page = (controller.page ?? 0).round();

    ///once the scrolling is finished => callback
    ///get the decimal part of controller.page and test when its equal 0
    if((controller.page ?? 0) - controller.page!.truncate()  == .0){
      widget.callback(widget.list[page]);
    }
  }

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemSize = constraints.maxWidth * _viewportFractionPerItem;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildShadowGradient(itemSize),
            _buildCarousel(itemSize),
            _buildSelectionItem(itemSize),
          ],
        );
      },
    );
  }

  ///the carousel itself, allow us to scroll items
  Widget _buildCarousel(double itemSize) {
    return Container(
      height: itemSize,
      margin: widget.padding,
      child: PageView.builder(
        controller: controller,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
              animation: controller,
              builder: (context, child){
                if (!controller.hasClients ||
                    !controller.position.hasContentDimensions) {
                  // The PageViewController isn't connected to the
                  // PageView widget yet. Return an empty box.
                  return const SizedBox();
                }

                final selectedIndex = controller.page!.roundToDouble();
                final maxScrollDistance = widget.itemPerScreen! / 2;
                final pageScrollAmount = controller.page! - selectedIndex;
                final pageDistanceFromSelected =
                (selectedIndex - index + pageScrollAmount).abs();
                final percentFromCenter =
                    1.0 - pageDistanceFromSelected / maxScrollDistance;

                final itemScale = 0.9 + (percentFromCenter * 0.5);
                final opacity = 0.25 + ((percentFromCenter * 0.75));

                return  Transform.scale(
                  scale: itemScale,
                  child: Opacity(
                  opacity: opacity,
                    child: Item(
                        callback: () =>{_onSelectorTapped(index)},
                        str: 'test ${index% widget.list.length}',
                        child: null,
                )));
              }
          );
        },
      ),
    );
  }

  void _onSelectorTapped(int index){
    controller.animateToPage(index, duration :const Duration(milliseconds: 150), curve: Curves.ease).then((value) => widget.callback(widget.list[page]));
  }

  /// background
  Widget _buildShadowGradient(double itemSize) {
    return SizedBox(
      height: itemSize * 2 + widget.padding.vertical,
      child:  DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  ///shape
  Widget _buildSelectionItem(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: widget.padding,
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.fromBorderSide(
                BorderSide(width: 6, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


///Les items du carousel
class Item extends StatelessWidget{
  final String str;
  final VoidCallback? callback;
  final Widget? child;
  const Item({
    super.key,
    required this.callback,
    required this.str,
    required this.child,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: callback,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child : Text(str) ,
            )
        ),
      ),
    ) ;
  }
}
