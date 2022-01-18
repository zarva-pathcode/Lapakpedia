import 'package:flutter/material.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';
import 'package:flutter_app/app/logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class SelectCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProv>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductProv>(
          builder: (context, provider, ch) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Pilih Kategorinya",
                  style: AppModule.largeText,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: provider.listCategory.length,
                  itemBuilder: (context, i) {
                    var _category = provider.listCategory[i];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, _category);
                        _provider.category = _category;
                      },
                      child: SizedBox(
                        height: 60,
                        child: Card(
                          child: Center(
                            child: Text(
                              _category.categoryName,
                              style: AppModule.largeText.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
