import 'package:flutter/material.dart';
import 'package:transita3/generated/l10n.dart';

class OlvidarContrasenya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).recoverpassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/transitaLogoBN.png',
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              S.of(context).emailsent,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              S.of(context).emailsendtouser,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
