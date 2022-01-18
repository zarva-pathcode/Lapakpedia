import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/logic/config/app_module.dart';

class MainFormField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback onTap;
  final VoidCallback onEditingCompleted;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final InputDecoration decoration;
  final List<RegExp> validation;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final bool isMulti;
  final bool isPassword;
  final bool autofocus;
  final bool enabled;
  final bool isBordered;
  final String errorText;
  final String label;
  final Widget suffix;
  final Widget prefix;

  MainFormField({
    Key key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onTap,
    this.validation = const [],
    this.isMulti = false,
    this.readOnly = false,
    this.inputFormatters,
    this.autofocus = false,
    this.isPassword = false,
    this.errorText,
    @required this.label,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.isBordered = false,
  }) : super(key: key);

  @override
  State<MainFormField> createState() => _MainFormFieldState();
}

class _MainFormFieldState extends State<MainFormField> {
  bool _obscureText;
  TextEditingController _controller;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    if (widget.initialValue != null) {
      if (_controller == null) {
        _controller = TextEditingController();
      }
      _controller.text = widget.initialValue;
    }
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (_obscureText == null) {
      _obscureText = widget.obscureText;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: TextField(
          inputFormatters: widget.inputFormatters,
          onChanged: (val) {
            if (widget.onChanged != null) {
              widget.onChanged(val);
            }
          },
          onEditingComplete: widget.onEditingCompleted,
          autofocus: widget.autofocus,
          minLines: widget.isMulti ? 4 : 1,
          maxLines: widget.isMulti ? null : 1,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          controller: _controller,
          style: AppModule.mediumText,
          decoration: widget.decoration == null
              ? InputDecoration(
                  errorText: widget.errorText,
                  errorStyle:
                      AppModule.formText.copyWith(color: Colors.red[600]),
                  prefixIcon: widget.prefix,
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : widget.suffix,
                  labelStyle:
                      AppModule.formText.copyWith(color: Colors.grey[400]),
                  labelText: widget.label,
                  hintStyle:
                      AppModule.formText.copyWith(color: Colors.grey[400]),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                  // enabledBorder: textFieldfocused(),
                  border: widget.isBordered
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                          ),
                        )
                      : null
                  // focusedBorder: textFieldfocused(),
                  // errorBorder: errorrTextFieldBorder(),
                  // focusedErrorBorder: errorrTextFieldBorder(),
                  )
              : widget.decoration),
    );
  }
}
