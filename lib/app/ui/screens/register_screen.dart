import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_provider.dart';
import 'package:flutter_app/app/ui/widgets/decor_button.dart';
import 'package:flutter_app/app/ui/widgets/main_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String email;

  RegisterScreen({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "Sign Up",
                      style: AppModule.headerText
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "kamu belum memiliki akun",
                      style: AppModule.regularText.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 50),
                    MainFormField(
                      isBordered: true,
                      label: "Nama Lengkap",
                      onChanged: (val) => _auth.username = val,
                      keyboardType: TextInputType.text,
                    ),
                    MainFormField(
                      isBordered: true,
                      label: "Password",
                      onChanged: (val) => _auth.password = val,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    MainFormField(
                      isBordered: true,
                      label: "No HP",
                      onChanged: (val) => _auth.phone = val,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DecorButton(
                      onTap: () {
                        _auth.register(context);
                      },
                      icon: FontAwesomeIcons.doorOpen,
                      label: "Sign Up",
                      gradient: [Colors.indigo[800], Colors.indigo[300]],
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DecorButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      icon: FontAwesomeIcons.arrowLeft,
                      label: "Back",
                      gradient: [Colors.black, Colors.grey[600]],
                      width: double.infinity,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
