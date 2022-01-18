import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DecorButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final Function onTap;
  final double width;

  const DecorButton({
    Key key,
    this.label,
    this.icon,
    this.gradient,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 14,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: Offset(0, 2),
              color: Colors.grey[400],
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                label,
                style: AppModule.regularText
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
