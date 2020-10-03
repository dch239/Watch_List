import 'package:flutter/material.dart';

showSnackBar({final scaffoldKey, String message}) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    backgroundColor: Colors.grey,
    content: Text(message),
  ));
}
