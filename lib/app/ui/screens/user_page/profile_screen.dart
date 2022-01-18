import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/provider/auth_provider.dart';
import 'package:flutter_app/app/routes/routes_name.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _data = Provider.of<AuthData>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.indigo),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          backgroundImage:
                              AssetImage("assets/images/person.jpg"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _data.username,
                            style: AppModule.mediumText.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.pin_drop_rounded,
                                size: 14,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 40,
                                child: Text(
                                  "Kab.Banyumas, Kec.Sumbang, Desa Banteran, Gang Apel No.43, rt01/rw05",
                                  style: AppModule.smallText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                _profileColumn(Icons.person_pin_outlined, "Profile Data",
                    onTap: () {
                  Navigator.pushNamed(context, profileData);
                }),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                _profileColumn(
                  Icons.alternate_email_rounded,
                  "Change Email Address",
                  onTap: () {},
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                _profileColumn(
                  Icons.password_rounded,
                  "Change Password",
                  onTap: () {},
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                _profileColumn(
                  Icons.short_text_sharp,
                  "Change Username",
                  onTap: () {},
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  height: 200,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                _profileColumn(
                  Icons.logout_rounded,
                  "Log Out",
                  onTap: () {
                    AppModule.toast.init(context);
                    AppModule.showConfirmation(
                      context,
                      title: "Account Confirmation",
                      content: "You sure want to logout?",
                      cancelText: "Cancel",
                      confirmText: "Sure",
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout(context)
                            .then((_) {
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                  iconCol: Colors.red[700],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileColumn(IconData icon, String text,
      {Function onTap, Color iconCol}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      leading: Icon(
        icon,
        color: iconCol,
      ),
      title: Text(
        text,
        style: AppModule.mediumText,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey[400],
        size: 20,
      ),
    );
  }
}
