import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/admin_page/category_field.dart';
import 'package:flutter_app/app/ui/widgets/admin_widget/date_picker.dart';
import 'package:flutter_app/app/ui/widgets/main_form_field.dart';
import 'package:flutter_app/app/ui/widgets/user_widget.dart/app_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Category category;

  @override
  void initState() {
    super.initState();
    AppModule.toast.init(context);
    setUp();
  }

  setUp() {
    Provider.of<ProductProv>(context, listen: false).setClear();
  }

  @override
  void dispose() {
    super.dispose();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<ProductProv>(context, listen: false);
    var placeHolder = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/images/default_image.jpg",
              fit: BoxFit.cover)),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 26,
            ),
            child: Column(
              children: [
                MyAppBar(
                  header: "Tambah Produk",
                ),
                SizedBox(
                  height: 20,
                ),
                CategoryTextField(),
                MainFormField(
                  label: "Nama Produk",
                  keyboardType: TextInputType.text,
                  onChanged: (val) => _product.productName = val,
                ),
                MainFormField(
                  label: "Deskripsi",
                  keyboardType: TextInputType.text,
                  onChanged: (val) => _product.desc = val,
                ),
                MainFormField(
                  label: "Kuantiti",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"[ ]")),
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (val) => _product.qty = val,
                ),
                MainFormField(
                  label: "Harga",
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"[ ]")),
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (val) => _product.price = val,
                ),
                // Consumer<ProductProv>(
                //   builder: (context, data, ch) => DatePickerDropDown(
                //     label: "Atur exp",
                //     style: AppModule.mediumText,
                //     value: DateFormat("yyyy-MM-dd").format(data.dateNow),
                //     onPressed: () {
                //       _product.selectDate(context);
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 180,
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text("Pick image from?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _product.pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Gallery"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _product.pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Camera"),
                                    ),
                                  ],
                                ));
                      },
                      child: Consumer<ProductProv>(
                        builder: (context, data, ch) => data.image == null
                            ? placeHolder
                            : Image.file(
                                data.image,
                                fit: BoxFit.fill,
                              ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    _product.addProduct(context);
                  },
                  child: Consumer<ProductProv>(
                    builder: (context, data, ch) => data.loadingProduct
                        ? CircularProgressIndicator()
                        : Text(
                            "Submit",
                            style: AppModule.regularText
                                .copyWith(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
