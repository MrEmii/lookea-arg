import "package:datetime_picker_formfield/datetime_picker_formfield.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

import 'LColors.dart';

class DateInput extends StatelessWidget{

  final String placeholder;
  final EdgeInsets padding;
  final TextAlign textAlign;
  final TextEditingController controller;
  final FormFieldValidator<DateTime> validator;
  final Function onChanged;
  final Function(BuildContext, DateTime) onShowPicker;
  final double width;
  final EdgeInsets margin;

  DateInput({this.placeholder, this.textAlign, this.padding, this.controller, this.validator, this.onChanged, this.onShowPicker, this.width, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      width:  width ?? 100,
      margin:  margin ?? EdgeInsets.zero,
      child: DateTimeField(
        readOnly: true,
        onChanged: this.onChanged,
        validator: this.validator,
        controller: this.controller,
        textAlign: this.textAlign ?? TextAlign.left,
        format: DateFormat("dd/MM/yyyy"),
        style: TextStyle(
          color: LColors.black9,
          fontSize: 14
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
           enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.white19, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.white19, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.white19, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.red61, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: LColors.red61, width: 0.25),
            borderRadius: BorderRadius.all(const Radius.circular(10.0))
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: this.placeholder,
          hintStyle: TextStyle(fontSize: 14, color: LColors.white19, fontWeight: FontWeight.w300),
        ),
        onShowPicker: this.onShowPicker ?? (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }

}
