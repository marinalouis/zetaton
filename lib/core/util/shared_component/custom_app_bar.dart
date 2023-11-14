import 'package:flutter/material.dart';
import 'package:zetaton/components/app_bar/logout_dialoge.dart';

AppBar customAppBar(String? title, BuildContext context) {
  return AppBar(
    title: Text(
      title ?? '',
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          showLogoutDialog(context);
        },
      )
    ],
  );
}
