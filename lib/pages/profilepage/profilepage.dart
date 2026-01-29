
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(


        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 50,),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Arun",style: TextStyle(fontSize: 20),),
            ),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  _rowButton(icon:Icons.message_outlined,title:'Message'),
                  _rowButton(icon:Icons.call_outlined,title:'Audio'),
                  _rowButton(icon:Icons.videocam_outlined,title:'Video'),
                  _rowButton(icon:Icons.note_alt_outlined,title:'Note'),
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
    );
  }

  Widget _rowButton({required IconData icon, required String title,}) {

    return Container(
      decoration: BoxDecoration(

       border: Border.all(width: 2,color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(10),

      ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    ),
    );
  }

  Widget _columnButton({required IconData icon, required String title, String? subtitle, bool? showToggle}) {

    return Row(
      children: [

        Icon(icon,size: 20,),
        SizedBox(width: 20,),

        Column(
          children: [
            Text(title,style: TextStyle(fontSize: 20), ),

            if(subtitle!=null)
              Text(subtitle,style: TextStyle(fontSize: 14,color: Colors.grey),)
          ],
        ),

        if(showToggle!=null && showToggle)
          Switch(value: false, onChanged: (value){})





      ],
    );
  }
}
