import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/pages/homepage/homepage.dart';



final goRouterProvider = Provider((ref){
  return GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {

          ref.read(Authe)
          return const Homepage(user: user);
        },
      ),
    ],
  );
});