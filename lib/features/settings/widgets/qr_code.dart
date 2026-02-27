import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends ConsumerWidget {
  const QrCode({super.key});

  // final TabController _tabController = TabController(initialIndex:0,length: 2, vsync: null, )
  @override
  Widget build(BuildContext context, ref) {

    final user = ref.watch(firebaseAuthProvider).currentUser;

   if(user==null) {
     return Center(child: Text('Something Went Wrong user is null'),);
   }

    final avtarRadius = 40.0;
    return Scaffold(
      appBar: AppBar(title: Text('QR code'), actions: [


        IconButton(onPressed: (){}, icon: Icon(Icons.share)),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded)),

      ]),
      body: DefaultTabController(
        length: 2,
        // initialIndex: 1,
        // A scrollable widget MUST know its size in the non-scroll direction.
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(child: Text("QR CODE")),
                Tab(child: Text("SCAN CODE")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
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
                                  padding: EdgeInsets.fromLTRB(20, 20+avtarRadius, 20, 20),
                                  child: Column(
                                    children: [

                                      // SizedBox(height: avtarRadius,),
                                      Text(user.displayName.toString(),style: Theme.of(context).textTheme.titleMedium,),
                                      Text("LanternChat Contact",style: Theme.of(context).textTheme.bodySmall),
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

                              Positioned(top: -avtarRadius, child: CircularUserAvatar(imageUrl: user.photoURL,radius: avtarRadius,)),
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
                  ),
                  Text("Tabe2"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
