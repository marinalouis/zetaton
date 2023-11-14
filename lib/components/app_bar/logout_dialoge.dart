import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/services/user_provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Close the dialog and cancel the logout
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<UserProvider>(context, listen: false).signOut(context);

            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

// Usage in your widget
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LogoutDialog();
    },
  );
}
