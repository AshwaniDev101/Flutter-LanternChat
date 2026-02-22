

import 'package:firebase_auth/firebase_auth.dart';

extension LanternChatUser on User
{
  Map<String,dynamic> toMap()
  {
    return {
      'name':displayName,
      'email':email
    };
  }
}