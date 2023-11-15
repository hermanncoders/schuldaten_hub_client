import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

contactedBadge(contacted) {
  if (contacted == 1 || contacted == 2 || contacted == 3) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.red[900],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("K",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else {
    return Container();
  }
}

contactedDayBadge(contacted) {
  return (contacted == '1' || contacted == '2' || contacted == '3')
      ? Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: contacted == '1'
                  ? contactedSuccessColor
                  : contacted == '2'
                      ? contactedCalledBackColor
                      : contacted == '3'
                          ? contactedFailedColor
                          : contactedFailedColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: contacted == '1'
                  ? const Icon(Icons.local_phone_rounded)
                  : contacted == '2'
                      ? const Icon(
                          Icons.phone_callback_rounded,
                        )
                      : const Icon(Icons.phone_disabled_rounded),
            ),
          ),
        )
      : Container();
}

returnedBadge(returned) {
  if (returned == true) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: goneHomeColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("H",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else {
    return Container();
  }
}

excusedBadge(excused) {
  if (excused == true) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: excusedCheckColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("U",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.green[600],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("E",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}

missedTypeBadge(missedtype) {
  if (missedtype == 'missed') {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: missedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("F",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else if (missedtype == 'late') {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: lateColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("V",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else if (missedtype == 'none') {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: presentColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("A",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: homeColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("H",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      ),
    );
  }
}
