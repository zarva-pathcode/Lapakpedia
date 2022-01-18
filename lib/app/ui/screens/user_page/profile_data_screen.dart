import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class ProfileDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                  Text(
                    "Profile Data",
                    style: AppModule.headerText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
