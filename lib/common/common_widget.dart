
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:nfo/common/constant_theme.dart';
import 'package:select_form_field/select_form_field.dart';

Widget textField(String label,
    TextEditingController controller,
    {TextInputType type = TextInputType.text,
    int maxLine = 1}) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blueAccent)
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLine,
        style: const TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: ConstantTheme.nearlyBlue,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          helperStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ConstantTheme.c4,
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.2,
            color: ConstantTheme.c4,
          ),
        ),
        onEditingComplete: () {},
      ));
}

Widget selectField(String label,
    TextEditingController controller,
    List<Map<String, dynamic>> item) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blueAccent)
      ),
      child: SelectFormField(
        type: SelectFormFieldType.dialog,
        enableSearch: true,
        items: item,
        controller: controller,
        style: const TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: ConstantTheme.nearlyBlue,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          helperStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ConstantTheme.c4,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.2,
            color: ConstantTheme.c4,
          ),
        ),
        onEditingComplete: () {},
      ));
}

Widget multiSelectField(String label,
    List items, List? selected, Function setState) {
  return Container(
      margin: EdgeInsets.only(right: 25, left: 25, top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blueAccent)
      ),
      child: MultiSelectFormField(
        border: InputBorder.none,
        autovalidate: AutovalidateMode.disabled,
        chipBackGroundColor: Colors.red,
        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
        checkBoxActiveColor: Colors.red,
        checkBoxCheckColor: Colors.green,
        fillColor: Colors.white,
        title: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
        dataSource: items,
        textField: 'name',
        valueField: 'value',
        okButtonLabel: 'Chọn',
        cancelButtonLabel: 'Huỷ',
        // hintWidget: Text('Please choose one or more'),
        initialValue: selected,
        onSaved: (value) {
          if (value == null) return;
          setState(value);
        },
      ));
}