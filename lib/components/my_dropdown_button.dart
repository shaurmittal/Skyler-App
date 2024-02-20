import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  final List<String> items = ["NGO", "Volunteer"];
  String? typeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        alignment: Alignment.center,
        isDense: true,
        isExpanded: true,
        hint: Text("Are you an NGO or a Volunteer?"),
        items: items
            .map((String item) =>
                DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        value: typeController,
        onChanged: (String? value) {
          setState(() {
            typeController = value!;
          });
        },
      )),
    );
  }
}
