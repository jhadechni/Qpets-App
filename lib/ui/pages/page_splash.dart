import 'package:flutter/material.dart';

 
class Pagesplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: const Color.fromRGBO(127, 119, 198, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(

                  
                  children: [
                    Column(
                      children: [
                        _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                        _cardImage2(
                            'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png'),
                        
                      ],
                    ),
                    
                    Column(
                      children: [
                        _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                        _cardImagepet(
                            'https://media.discordapp.net/attachments/955549239801446473/955549292423172116/Corgi_logo_1.png'),
                      ],
                    ),
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        _cardImage(
                            'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                        _cardImage2(
                            'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png')
                      ],
                    ),

                    Column(children: [
                      _cardImage2(
                            'https://media.discordapp.net/attachments/955549239801446473/960039618248597534/Group_3.png'),
                       _cardImagelogo(
                        'https://media.discordapp.net/attachments/955549239801446473/960035755244269608/Vector.png'),

                    ],),
                   
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                  ],
                ),
                Row(
                  children: [
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png'),
                    _cardImagelogo(
                        'https://media.discordapp.net/attachments/955549239801446473/960037973200625724/Vector_1.png'),
                    _cardImage(
                        'https://media.discordapp.net/attachments/955549239801446473/960026024475770961/Group.png')
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget _cardImage(String link) {
    return Container(
        width:  100,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }
   Widget _cardImage2(String link) {
    return Container(
        width:  50,
        height: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(link), fit: BoxFit.fitWidth),
            borderRadius: BorderRadius.circular(10)));
  }

  Widget _cardImagepet(String link) {
    return SizedBox(
        width: 250,
        height: 250,
     child: Center(
          child: Image( image: NetworkImage(link),
          fit: BoxFit.fill,) 
        ));
  }

  Widget _cardImagelogo(String link) {
    return SizedBox(
        width: 200,
        height: 100,
        child: Center(
          child: Image( image: NetworkImage(link),
          fit: BoxFit.fill,) 
         
        ));
  }




  
}
