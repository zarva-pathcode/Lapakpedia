import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/product.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/admin_page/category_field.dart';
import 'package:flutter_app/app/ui/widgets/main_form_field.dart';
import 'package:flutter_app/app/ui/widgets/user_widget.dart/app_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  EditProductScreen(this.product);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  TextEditingController productNameC;
  TextEditingController descC;
  TextEditingController qtyC;
  TextEditingController priceC;
  TextEditingController categoryC;
  DateTime dateNow = DateTime.now();
  DateFormat format = DateFormat("yyyy-MM-dd");
  String selectedDate;

  @override
  void initState() {
    super.initState();
    setUp();
  }

  setUp() {
    Provider.of<ProductProv>(context, listen: false).setClear();
    categoryC =
        TextEditingController(text: widget.product.idCategory.toString());
    productNameC = TextEditingController(text: widget.product.productName);
    descC = TextEditingController(text: widget.product.desc);
    qtyC = TextEditingController(text: widget.product.qty.toString());
    priceC = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<ProductProv>(context, listen: false).setClear();
  }

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<ProductProv>(context, listen: true);

    var formatDate = DateFormat("yyyy-MM-dd");
    Future selectDate(BuildContext context) async {
      final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(selectedDate),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null && pickedDate != dateNow) {
        setState(() {
          dateNow = pickedDate;
          selectedDate = formatDate.format(dateNow);
        });
      } else {}
    }

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
                  header: "Edit Produk",
                ),
                SizedBox(
                  height: 30,
                ),
                CategoryTextField(
                  value: categoryC,
                ),
                MainFormField(
                  label: "Product Name",
                  keyboardType: TextInputType.text,
                  controller: productNameC,
                ),
                MainFormField(
                  label: "Description",
                  keyboardType: TextInputType.text,
                  controller: descC,
                ),
                MainFormField(
                  label: "Qty",
                  keyboardType: TextInputType.number,
                  controller: qtyC,
                ),
                MainFormField(
                  label: "Price",
                  keyboardType: TextInputType.number,
                  controller: priceC,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                      builder: (context, data, ch) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: data.image == null
                            ? CachedNetworkImage(
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                key: UniqueKey(),
                                cacheManager: AppModule.cacheManager,
                                imageUrl: AppModule.ImagePathURL +
                                    "/" +
                                    widget.product.image,
                                fit: BoxFit.cover,
                                height: 65,
                                width: double.infinity,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[200],
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[100],
                                  ),
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Image.file(
                                data.image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.indigo,
                  onPressed: () {
                    _product.editProduct(
                      context,
                      namaProduk: productNameC.text,
                      description: descC.text,
                      quantity: qtyC.text,
                      harga: priceC.text,
                      idProduct: widget.product.id.toString(),
                    );
                  },
                  child: Consumer<ProductProv>(
                    builder: (context, data, ch) =>
                        // data.loadingProduct
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           CircularProgressIndicator(),
                        //           SizedBox(width: 5),
                        //           Text(
                        //             "Loading..",
                        //             style: AppModule.regularText
                        //                 .copyWith(color: Colors.white),
                        //           ),
                        //         ],
                        //       )
                        //     :
                        Text(
                      "Edit",
                      style: AppModule.mediumText.copyWith(color: Colors.white),
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
