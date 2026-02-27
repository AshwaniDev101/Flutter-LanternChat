

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/providers/constant_providers.dart';
import '../../../../shared/widgets/circular_user_avatar.dart';

class ShowQrTab extends ConsumerWidget {
  const ShowQrTab({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final avtarRadius = 40.0;

    final user = ref
        .watch(firebaseAuthProvider)
        .currentUser;

    if (user == null) {
      return Center(child: Text('Something Went Wrong user is null'));
    }

    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20 + avtarRadius, 20, 20),
                    child: Column(
                      children: [
                        // SizedBox(height: avtarRadius,),
                        Text(user.displayName.toString(), style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium),
                        Text("LanternChat Contact", style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: QrImageView(data: user.uid),
                          // child: Image.network(
                          //   'https://www.freepnglogos.com/uploads/qr-code-png/qr-code-file-bangla-mobile-code-0.png',
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: -avtarRadius,
                  child: CircularUserAvatar(imageUrl: user.photoURL, radius: avtarRadius),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Your QR code is private. If you share it with someone, they can scan it with their LanternChat Camera to add you as a contact',
            ),
          ),
        ],
      ),
    );
  }
}
