import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';

Future<dynamic> errorTokenExpired(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(S.of(context).accountExpired),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
