

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/auth_provider.dart';

class UsernameSetupPage extends ConsumerWidget {
  const UsernameSetupPage({super.key});

  @override
  Widget build(BuildContext context, ref) {


    final user = ref.watch(firebaseAuthProvider).currentUser;

    if(user==null)
      {
        return Scaffold(
          body: Center(
            child: Text('UsernameSetupPage: Something went wrong 404'),
          ),
        );
      }


    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Text('Welcome', style: Theme.of(context).textTheme.headlineLarge),
              Text('${user.displayName}'),
              Text('${user.email}'),
              Text('${user.phoneNumber}'),
              Text('${user.emailVerified}'),
              Text('${user.metadata.creationTime}'),
              Text('${user.metadata.lastSignInTime}'),

            ]
          ),
        ),
      ),
    );
  }
}
