import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class DashboardContainer extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  const DashboardContainer({Key key, this.label, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[300],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(label, style: AppModule.mediumText)
          ],
        ),
      ),
    );
  }
}
