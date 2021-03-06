import 'package:flutter/material.dart';
import 'package:memby/constants.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class OrderCard extends StatelessWidget {
  OrderCard(
      {this.title,
      this.img,
      this.description,
      this.price,
      this.amount,
      this.setAmount});

  final String title;
  final String img;
  final double price;
  final String description;
  final int amount;
  final Function setAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        height: 120,
                        width: 120,
                        padding: EdgeInsets.all(5),
                        child: img != null
                            ? CircleAvatar(
                                radius: 5,
                                backgroundImage: NetworkImage(this.img),
                              )
                            : CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.grey.withOpacity(.5),
                              )),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: 200,
                          child: Text(
                            description,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('$price Baht/unit'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text('Amount:'),
                          Container(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                int num = int.parse(value);
                                if (num >= 1) {
                                  setAmount(int.parse(value));
                                }
                              },
                              controller: TextEditingController()
                                ..text = amount.toString(),
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'amount',
                              ),
                            ),
                            width: 100,
                            height: 40,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        decoration: DottedDecoration(
          shape: Shape.box,
          color: Color(0xFFB3ABBC),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
