import 'package:flutter/material.dart';

class ItemTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<bool> onChanged;
  final bool value;

  const ItemTextField({
    Key key,
    @required this.value,
    @required this.onChanged, 
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
      onChanged: onChanged,
      value: value,
    );
  }
}