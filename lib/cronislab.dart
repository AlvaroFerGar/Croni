import 'package:flutter/material.dart';

class CroniSlabStatelessWidget extends StatelessWidget {
  const CroniSlabStatelessWidget({
    Key? key,
    required this.emoji,
    required this.eventTypeName,
    required this.eventName,
    required this.bckgcolor,
  }) : super(key: key);

  final Color bckgcolor;
  final String eventTypeName;
  final String emoji;
  final String eventName;
  final double borderRadius = 5;
  final TextStyle emojiTextStyle = const TextStyle(fontSize: 40);
  final TextStyle typeTextStyle =  const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);
  final TextStyle nameTextStyle = const TextStyle(fontSize: 22, color: Colors.white);


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 125),
      decoration: BoxDecoration(
          color: bckgcolor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            child: Text(
              emoji,
              style: emojiTextStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            child: Text(
              eventTypeName,
              style: typeTextStyle,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            child: Text(
              eventName,
              style: nameTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
