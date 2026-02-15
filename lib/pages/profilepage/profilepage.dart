
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {


    final user = ref.watch(firebaseAuthProvider).currentUser;

    if(user==null)
      {
        return Scaffold(
          body:Center(
            child: Text("Something went Wrong 404"),
          ),
        );
      }
    return Scaffold(

      body: SafeArea(


        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(radius: 60,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${user.displayName}',style: TextStyle(fontSize: 20),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(child: _rowButton(icon:Icons.message_outlined,title:'Message')),
                    SizedBox(width: 10,),
                    Expanded(child: _rowButton(icon:Icons.call_outlined,title:'Audio')),
                    SizedBox(width: 10,),
                    Expanded(child: _rowButton(icon:Icons.videocam_outlined,title:'Video')),
                    SizedBox(width: 10,),
                    Expanded(child: _rowButton(icon:Icons.note_alt_outlined,title:'Note')),
                  ],
                ),
              ),

              _columnButton(icon:Icons.notifications_none_outlined,title:'Notifications'),
              _columnButton(icon:Icons.star_border_outlined,title:'Starred messages'),
              _columnButton(icon:Icons.lock_outline_rounded,title:'Encryption',subtitle:"Messages and calls are end-to-end encrypted. Tap to verify"),
              _columnButton(icon:Icons.timer,title:'Disappearing messages',subtitle:'Off'),
              _columnButton(icon:Icons.mail_lock_outlined,title:'Chat lock',subtitle: "Lock and hide this chat on this device", showToggle:true),
              _columnButton(icon:Icons.mail_lock_outlined,title:'Advance chat privacy',subtitle: "Off",),


            ],
          ),
        ),
      ),
    );
  }

  Widget _rowButton({required IconData icon, required String title,}) {

    return Container(
      decoration: BoxDecoration(

       border: Border.all(width: 2,color: Colors.grey),
        borderRadius: BorderRadius.circular(10),

      ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(icon,size: 24,),
          Text(title,style: TextStyle(fontSize: 16),),
        ],
      ),
    ),
    );
  }

  Widget _columnButton({required IconData icon, required String title, String? subtitle, bool? showToggle}) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [

          Icon(icon,size: 24,),
          SizedBox(width: 18,),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(fontSize: 18), ),

                if(subtitle!=null)
                  Text(subtitle,softWrap: true, style: TextStyle(fontSize: 14,color: Colors.grey,),)
              ],
            ),
          ),

          if(showToggle!=null && showToggle)
            Switch(value: false, onChanged: (value){},)





        ],
      ),
    );
  }
}
