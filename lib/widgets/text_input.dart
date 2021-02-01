import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookea/widgets/LIcons.dart';
import 'package:lookea/widgets/LColors.dart';

class TextInputComponent extends StatefulWidget {

  final String placeholder;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType type;
  final bool passwordEnabled;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool filled;
  final Color fillColor;
  final TextStyle placeholderStyle;
  final TextStyle style;
  final EdgeInsets contentPadding;
  final InputBorder enabledBorder;
  final InputBorder border;
  final bool multiLine;
  final List<TextInputFormatter> inputFormatters;
  final bool readOnly;
  final FocusNode node;
  final TextInputAction action;
  final Function(String) onSubmit;
  final double width;
  final EdgeInsets margin;
  final bool autoFocus;
  final TextCapitalization capitalization;
  final Function(String) onChanged;
  final bool autocorrect;
  final Function onTap;

  TextInputComponent({Key key, this.width, this.onTap, this.autocorrect = true, this.capitalization, this.suffixIcon, this.autoFocus = false, this.action, this.onSubmit, this.node, this.readOnly = false, this.inputFormatters, this.prefixIcon, this.placeholder, this.padding, this.textAlign, this.controller, this.validator, this.type, this.passwordEnabled, this.filled, this.fillColor, this.placeholderStyle, this.border, this.enabledBorder, this.contentPadding, this.style, this.multiLine, this.margin, this.onChanged});

  @override
  _TextInputComponentState createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  final key = GlobalKey();

  bool hiddenPass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.widget.padding ?? EdgeInsets.zero,
      width:  this.widget.width ?? 100,
      margin:  this.widget.margin ?? EdgeInsets.zero,
      child: TextFormField(
        key: key,
        onTap: widget.onTap,
        textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
        autofocus: widget.autoFocus,
        autocorrect: widget.autocorrect,
        focusNode: this.widget.node,
        textInputAction: this.widget.action,
        onChanged: this.widget.onChanged,
        onFieldSubmitted: this.widget.onSubmit,
        controller: this.widget.controller,
        readOnly: this.widget.readOnly,
        textAlign: this.widget.textAlign ?? TextAlign.left,
        validator: this.widget.validator,
        inputFormatters: this.widget.inputFormatters,
        obscureText: (this.widget.passwordEnabled ?? false) ? this.hiddenPass : false,
        keyboardType: this.widget.type ?? TextInputType.text,
        maxLines: (this.widget.multiLine == null ? false : this.widget.multiLine) ? null : 1,
        style: this.widget.style ?? TextStyle(
          color: LColors.black9,
          fontSize: 14
        ),
        decoration: InputDecoration(
          contentPadding: this.widget.contentPadding ?? EdgeInsets.only(left: 10),
          prefixIcon: this.widget.prefixIcon,
          suffixIcon: this.widget.passwordEnabled ?? false ? GestureDetector(
              onTap: (){
                setState(() {
                  this.hiddenPass = !this.hiddenPass;
                });
              },
              child: Icon( this.hiddenPass ? LIcons.eye_slash : LIcons.eye, color: Colors.black26, size: 18,),
            ) : widget.suffixIcon ?? null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.gray4, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(14.0))
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.gray4, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(14.0))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.gray4, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(14.0))
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.red61, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(14.0))
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.red61, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(14.0))
          ),
          filled: this.widget.filled ?? true,
          fillColor: this.widget.fillColor ?? Colors.white,
          hintText: this.widget.placeholder,
          hintStyle: this.widget.placeholderStyle ?? TextStyle(fontSize: 14, color: LColors.white19, fontWeight: FontWeight.w300),
          alignLabelWithHint: true
        ),
      ),
    );
  }
}