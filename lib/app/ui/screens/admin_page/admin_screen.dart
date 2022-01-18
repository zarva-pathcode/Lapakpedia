import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/auth_data.dart';
import 'package:flutter_app/app/logic/provider/auth_provider.dart';
import 'package:flutter_app/app/routes/routes_name.dart';
import 'package:flutter_app/app/ui/screens/admin_page/add_product_screen.dart';
import 'package:flutter_app/app/ui/screens/admin_page/daftar_barang_screen.dart';
import 'package:flutter_app/app/ui/widgets/admin_widget/dashboard_container.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  checkUser() async {
    final _auth = await Provider.of<AuthData>(context, listen: false);
    _auth.getPref();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        title: Text(
          "Halo ${data.username}",
          style: AppModule.largeText.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout(context);
            },
            icon: Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardContainer(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DaftarBarang()));
                    },
                    label: "Daftar Barang",
                    icon: Icons.space_dashboard_rounded,
                  ),
                  DashboardContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductScreen(),
                        ),
                      );
                    },
                    label: "Tambah Barang",
                    icon: Icons.dashboard_customize_outlined,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardContainer(
                    onTap: () {},
                    label: "Laporan",
                    icon: Icons.analytics,
                  ),
                  DashboardContainer(
                    onTap: () {
                      Navigator.pushNamed(context, loadingRoute);
                    },
                    label: "Akun",
                    icon: Icons.account_box,
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
