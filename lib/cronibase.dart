import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';


class CroniType {
  const CroniType({
    required this.name,
    required this.emoji,
    required this.color,
  });

  final String name;
  final Emoji emoji;
  final Color color;
}


class CroniEvent {

  CroniEvent({
    required this.type,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  final CroniType type;
  final String name;
  final DateTime startDate;
  String description="";
  DateTime endDate;
  bool finished=true;
}