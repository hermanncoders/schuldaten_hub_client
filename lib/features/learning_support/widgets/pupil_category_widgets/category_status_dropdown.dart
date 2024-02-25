import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> categoryStatusItems = [
  DropdownMenuItem(
    value: 'white',
    child: SizedBox(width: 40, child: Image.asset('assets/growth_1-4.png')),
  ),
  DropdownMenuItem(
    value: 'red',
    child: SizedBox(width: 40, child: Image.asset('assets/growth_2-4.png')),
  ),
  DropdownMenuItem(
    value: 'yellow',
    child: SizedBox(width: 40, child: Image.asset('assets/growth_3-4.png')),
  ),
  DropdownMenuItem(
    value: 'green',
    child: SizedBox(width: 40, child: Image.asset('assets/growth_4-4.png')),
  ),
];
