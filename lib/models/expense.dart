import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final formatter = DateFormat.yMd();
final uuid = Uuid();
enum Category{
  Food,
  Transportation,
  Personal,
  Entertainment,
  Health,
  Other,
}
const categoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Transportation: Icons.directions_bus,
  Category.Personal: Icons.person,
  Category.Entertainment: Icons.movie,
  Category.Health: Icons.local_hospital,
  Category.Other: Icons.money,

};
class Expense{
  Expense({ required this.title, required this.amount, required this.date,required this.category, }) : id = uuid.v4();
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }

}