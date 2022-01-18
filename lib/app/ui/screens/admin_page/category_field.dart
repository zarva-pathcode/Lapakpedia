import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/models/category.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:flutter_app/app/ui/screens/admin_page/select_category.dart';
import 'package:provider/provider.dart';

class CategoryTextField extends StatefulWidget {
  final TextEditingController value;

  const CategoryTextField({Key key, this.value}) : super(key: key);
  @override
  _CategoryTextFieldState createState() => _CategoryTextFieldState();
}

class _CategoryTextFieldState extends State<CategoryTextField> {
  TextEditingController _controller;
  Category _category;

  @override
  void initState() {
    if (widget.value != null) {
      _controller = widget.value;
    }
    _controller = TextEditingController();
    super.initState();
  }

  pilihCategory() async {
    await Provider.of<ProductProv>(context, listen: false).getCategory(context);
    _category = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => SelectCategory(),
      ),
    );
    setState(() {
      _controller = TextEditingController(text: _category.categoryName);
      // _product.category.categoryName = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        pilihCategory();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: TextField(
          enabled: false,
          controller: _controller,
          decoration: InputDecoration(
            errorStyle: AppModule.formText.copyWith(color: Colors.red[600]),
            labelStyle: AppModule.formText.copyWith(color: Colors.grey[400]),
            labelText: "Kategori Produk",
            hintStyle: AppModule.formText.copyWith(color: Colors.grey[400]),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          ),
        ),
      ),
    );
  }
}
