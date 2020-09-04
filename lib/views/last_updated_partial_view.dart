import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LastUpdatedPartialView extends StatelessWidget {
  final DateTime dateTime;

  LastUpdatedPartialView({
    Key key,
    @required this.dateTime,
  })  : assert(dateTime != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
