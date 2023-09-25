import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String str;
  final bool isRight;
  final Function push;
  const CustomButton({super.key, required this.str, required this.isRight, required this.push});


  @override
  Widget build(BuildContext context){
    return Align(
      alignment: isRight ? const Alignment(-1, 0) : const Alignment(1, 0),
      child: InkWell(
        onTap: (){
          push();
        },
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.width * .1,
          child: Center(child: Text(str),),
        ),
      ),
    );
  }
}