import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class DatePickerDropDown extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle style;
  final Function onPressed;
  final Widget child;

  const DatePickerDropDown(
      {Key key, this.label, this.value, this.style, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: InputDecorator(
          baseStyle: AppModule.regularText.copyWith(color: Colors.grey[300]),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              labelText: label,
              hintStyle: AppModule.mediumText),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: style),
              Icon(Icons.calendar_today_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
