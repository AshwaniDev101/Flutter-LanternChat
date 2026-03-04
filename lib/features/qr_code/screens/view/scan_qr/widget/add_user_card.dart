import 'package:flutter/material.dart';

import '../../../../../../models/app_user.dart';
import '../../../../../../shared/widgets/circular_user_avatar.dart';


class FoundUserCard extends StatelessWidget {
  final AppUser appUser;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  const FoundUserCard({required this.appUser, required this.onCancel, required this.onAdd, super.key});

  @override
  Widget build(BuildContext context) {
    final avtarRadius = 40.0;

    final buttonCornerRadius = 16.0;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentGeometry.topCenter,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20 + avtarRadius, 20, 20),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text(appUser.name, style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 8),
                      Text(appUser.email, style: Theme.of(context).textTheme.bodyMedium),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: onCancel,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.only(
                                        topLeft: Radius.circular(buttonCornerRadius),
                                        bottomLeft: Radius.circular(buttonCornerRadius),
                                      ),
                                    ),

                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text("Cancel"),
                                ),
                              ),

                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: onAdd,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.only(
                                        topRight: Radius.circular(buttonCornerRadius),
                                        bottomRight: Radius.circular(buttonCornerRadius),
                                      ),
                                    ),
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text("Add"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('Add to Connections?', style: Theme.of(context).textTheme.labelSmall),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: -avtarRadius,
                child: CircularUserAvatar(imageUrl: appUser.photoURL, radius: avtarRadius),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
