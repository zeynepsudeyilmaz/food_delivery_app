import 'package:flutter/material.dart';

class FilterComponent extends StatefulWidget {
  final Function(String) onSortChanged;

  const FilterComponent({super.key, required this.onSortChanged});

  @override
  _FilterComponentState createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
          value: selectedValue,
          hint: const Text('Sırala'),
          items: [
            DropdownMenuItem(value: 'name_asc', child: Text('İsim A-Z')),
            DropdownMenuItem(value: 'name_desc', child: Text('İsim Z-A')),
            DropdownMenuItem(value: 'price_asc', child: Text('Fiyat Artan')),
            DropdownMenuItem(value: 'price_desc', child: Text('Fiyat Azalan')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
              });
              widget.onSortChanged(value);
            }
          },
        ),
      ],
    );
  }
}
