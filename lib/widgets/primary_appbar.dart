import 'package:flutter/material.dart';

AppBar primaryAppBar(BuildContext context, {String? title}) {
  return AppBar(
    title: title != null ? Text(title) : null,
    
  );
}
