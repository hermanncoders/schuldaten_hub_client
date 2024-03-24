//- STYLES

import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle appBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 25,
);
const TextStyle filterItemsTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

const TextStyle buttonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const TextStyle title = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const TextStyle subtitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
    textStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: accentColor,
    minimumSize: const Size.fromHeight(50));

ButtonStyle cancelButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: cancelButtonColor,
    minimumSize: const Size.fromHeight(50));

ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: groupColor,
    minimumSize: const Size.fromHeight(50));
