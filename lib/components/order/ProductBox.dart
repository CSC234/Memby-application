import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class ProductBox extends StatelessWidget {
  ProductBox({this.img, this.title, this.isFilled, this.onPress});
  final String img;
  final String title;
  final bool isFilled;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        child: Container(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 70,
                    width: 70,
                    padding: EdgeInsets.all(5),
                    child: img != null
                        ? CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(this.img),
                          )
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey.withOpacity(.5),
                          )

                    // Image.asset(

                    //   'assets/images/product1.jpg',

                    //   width: 70,

                    // ),

                    ),
                Container(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                  ),
                  width: 100,
                ),
              ],
            ),
            height: 150,
            decoration: BoxDecoration(
              color: isFilled ? Color(0xFFDDDDDD) : null,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          decoration: DottedDecoration(
            shape: Shape.box,
            color: Color(0xFFB3ABBC),
            borderRadius:
                BorderRadius.circular(10), //remove this to get plane rectange
          ),
        ),
        onTap: onPress,
      ),
    );
  }
}
