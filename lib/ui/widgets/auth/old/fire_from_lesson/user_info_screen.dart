import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/api_client/firebase_service.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User name: ${user.displayName}'),
            Text('User email: ${user.email}'),
            StreamBuilder<User?>(
              stream: FirebaseService().auth.userChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.data == null) {
                  return Text('User not found');
                }
                final user = snapshot.data!;
                user.reload();
                if (user.emailVerified) {
                  return Text('Email: is Verify: ${user.emailVerified}');
                } else {
                  return Column(
                    children: [
                      Text('Email: is Verify: ${user.emailVerified}'),
                      TextButton(
                        onPressed: () {
                          FirebaseService().onVerifyEmail();
                        },
                        child: Text('Verify Email'),
                      ),
                    ],
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                FirebaseService().logOut();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
