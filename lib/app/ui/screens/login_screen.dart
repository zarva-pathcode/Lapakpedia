import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_provider.dart';
import 'package:flutter_app/app/ui/widgets/decor_button.dart';
import 'package:flutter_app/app/ui/widgets/main_form_field.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    final RefreshController _refreshController =
        RefreshController(initialRefresh: true);
    void _onRefresh() async {
      AppModule.toast.init(context);

      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: AppModule.headerText
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign In akun kamu disini",
                    style: AppModule.regularText.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 50),
                  MainFormField(
                    label: "Email",
                    onChanged: (val) => _auth.email = val,
                    isBordered: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  MainFormField(
                    label: "Password",
                    obscureText: true,
                    isBordered: true,
                    keyboardType: TextInputType.text,
                    onChanged: (val) => _auth.password = val,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DecorButton(
                    icon: FontAwesomeIcons.doorOpen,
                    label: "Enter",
                    gradient: [Colors.indigo[800], Colors.indigo[300]],
                    width: double.infinity,
                    onTap: () {
                      _auth.manualLogin(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecorButton(
                        onTap: () {
                          AppModule.toast.init(context);
                          _auth.googleLogin(context);
                        },
                        icon: FontAwesomeIcons.google,
                        label: "Google",
                        gradient: [
                          Colors.red[900],
                          Colors.red[300],
                        ],
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DecorButton(
                        icon: FontAwesomeIcons.facebook,
                        label: "Facebook",
                        gradient: [
                          Colors.blue[900],
                          Colors.blue[400],
                        ],
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
