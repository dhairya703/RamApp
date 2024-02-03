import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ramram/pages/media.dart';
import 'package:ramram/pages/ramjap.dart';
import 'package:ramram/views/card.dart';
import 'package:ramram/views/images.dart';
import 'package:lottie/lottie.dart';
final List<String> imgList = [
'https://firebasestorage.googleapis.com/v0/b/dumy-6597a.appspot.com/o/img1.jpg?alt=media&token=dc49337c-b54d-4bdf-a807-39b8fc1eebde',
'https://firebasestorage.googleapis.com/v0/b/dumy-6597a.appspot.com/o/download.jpeg?alt=media&token=da733b50-a506-40f3-a187-7c5fc88d978f',
  'https://firebasestorage.googleapis.com/v0/b/dumy-6597a.appspot.com/o/medium-shri-ram-ji-lakshmana-ji-with-hanuman-ji-decorative-original-imafjrjvkpp9tap6.webp?alt=media&token=82c11eb3-d3bb-469b-9aa3-983d39b16229',
  'https://firebasestorage.googleapis.com/v0/b/dumy-6597a.appspot.com/o/ram-ji-with-purple-mandala-art-l38s21uz8hfh79ad.jpg?alt=media&token=b8c15a54-95e3-43c7-9df3-9c21ddf4fb83',
  'https://firebasestorage.googleapis.com/v0/b/dumy-6597a.appspot.com/o/71vMA0synCL.jpg?alt=media&token=86e671dc-f27d-494e-a917-bcb40d5d3756',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            width: 100.0,
            height: 100.0,
            child: Lottie.network(
              'https://lottie.host/2e116016-79dd-4d23-8789-b501aaffa78f/IUiTlwLbmS.json',
            ),
          ),
          title: Text("श्री राम जय राम जय जय राम"),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.vertical,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                ),
              ),
              SizedBox(height: 10,),
      YearCard(
            year: 1853,
event: 'The first recorded religious violence in 1853, over 230 years after the Babri Masjids construction.A Hindu sect claimed a temple was destroyed during Baburs rule.'),
          SizedBox(height: 10,),YearCard(
            year: 1885,
            event:
'In January 1885, Mahant Raghubir Das sought permission to build a canopy on Ramchabutra outside the mosque. The plea was rejected.'          ),
              SizedBox(height: 10,),YearCard(
            year: 1949,
            event:
'Gopal Singh Visharad petitioned to worship Ram Lalla after idols were found in Babri Masjid. Civil suits ensued, and the government declared the area disputed, locking the gates.'
          ),
              SizedBox(height: 10,),YearCard(
            year: 1961,
            event: "Mohammad Hashim filed a suit for the restoration of the property to Muslims. The Sunni Central Wakf Board also filed a suit declaring Babri Mosque as its property.",
          ),
              SizedBox(height: 10,), YearCard(
            year: 1984,
            event: "Vishwa Hindu Parishad (VHP) initiates a movement to 'liberate' the birthplace of Lord Ram and build a temple. LK Advani takes over the leadership of the campaign.",
          ),
              SizedBox(height: 10,),  YearCard(
            year: 1986,
            event: "Ayodhya District judge orders the gates of the disputed mosque to be opened for Hindus to worship. Babri Mosque Action Committee is set up in protest.",
          ),
              SizedBox(height: 10,),YearCard(
              year: 1989,
              event:"VHP lays foundations of a Ram temple near the disputed mosque. Four suits are transferred to a special bench of the High Court"
          ),
              SizedBox(height: 10,), YearCard(
              year:1990,
              event:"BJP, under LK Advani, orders a national Rath Yatra, leading to communal riots. VHP volunteers partially damage the mosque. Prime Minister Chandra Shekhar attempts negotiations."
          ),SizedBox(height: 10,),YearCard(
              year:1992 ,
              event:"On December 6, the mosque is torn down by VHP, Shiv Sena, and BJP supporters, causing nationwide rioting. Over 2,000 people died."
          ),SizedBox(height: 10,),YearCard(
              year: 1998,
              event:"BJP forms a coalition government under Prime Minister Atal Behari Vajpayee."
          ),SizedBox(height: 10,),YearCard(
              year: 2001,
              event:"Tensions rise on the anniversary of the mosque's demolition. VHP pledges to build a Hindu temple. Vajpayee sets up an Ayodhya cell for talks."
          ),SizedBox(height: 10,),YearCard(
              year:2002 ,
              event:"BJP rules out committing to the temple's construction in its election manifesto. VHP sets a deadline for construction, leading to communal tensions. Godhra train attack results in 58 deaths."
          ),
              SizedBox(height: 10,), YearCard(
              year: 2010,
              event:"Allahabad High Court orders the disputed site to be divided among Hindus, Muslims, and Nirmohi Akhara. Appeals filed by various parties."

          ),SizedBox(height: 10,),YearCard(
              year:2019 ,
              event:"Supreme Court orders the disputed land to be handed to a trust for the Ram Janmabhoomi temple. Five acres allocated to Sunni Waqf Board for a mosque."
          ),SizedBox(height: 10,),YearCard(
              year: 2020,
              event:"Foundation stone for the Ram Temple laid by PM Narendra Modi on August 5."
          ),SizedBox(height: 10,),YearCard(
              year:2022
              ,
              event:"Foundation stone for the Ram Temple laid by PM Narendra Modi on August 5."
          ),SizedBox(height: 10,),YearCard(
              year:2024 ,
              event:"PM Modi to attend the inauguration of the Ram Mandir on January 22, 2024. 'Pran Pratishtha' or consecration ceremony takes place."
          ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Lottie.network('https://lottie.host/2e116016-79dd-4d23-8789-b501aaffa78f/IUiTlwLbmS.json'),
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ramnam ()),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            switch (index) {
              case 0:

                break;
              case 1:
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MediaPage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );

                break;

            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Media',
            ),
            // Add more BottomNavigationBarItems as needed
          ],
        ),
      ),
    );
  }
}

