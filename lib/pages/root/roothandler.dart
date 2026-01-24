

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/pages/homepage/homepage.dart';

import '../../core/user_manager.dart';

class RootHandler extends ConsumerWidget {
  const RootHandler({super.key});

  @override
  Widget build(BuildContext context, ref) {


    final authUser = ref.watch(authStatusProvider);

    return Scaffold(

      body: switch(authUser){

      AsyncLoading() => CircularProgressIndicator(),

        AsyncError() => CircularProgressIndicator(),

        AsyncData(value:User user) => Homepage(user: user),

      _ => SizedBox(),

      },
    );
  }
}
