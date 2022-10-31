//estilizando a data de lançamento do filme

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Release_Date extends StatelessWidget {

  final DateTime date;
  final String dateFormat;

  const Release_Date({super.key, required this.date, required this.dateFormat});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.red.withOpacity(0.9),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      avatar: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.calendar_today,
          size: 18,
          color: Colors.white,
        ),
      ),
      label: Text(
        DateFormat(dateFormat).format(date),
    textAlign: TextAlign.end,
    style: const TextStyle(
    fontSize: 18,
    color: Colors.white
    ),
    )
    );
  }
}
