import 'package:affirm/Frontend/Pages/player_page.dart';
import 'package:affirm/Frontend/Pages/recording_page.dart';
import 'package:affirm/Frontend/Utilities/custom_page_transition.dart';
import 'package:affirm/Frontend/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../shared_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
/*   Directory dir = Directory('/storage/emulated/0/Music');

  fiList() async {
    var i = await dir.list().length;
    return i;
  } */

/*   Future<File> localfile() async {
    var result = await Permission.storage.request();
    if (result.isGranted) {
      // permission was granted
      String imgPath = '/storage/emulated/0/Downloads';
      return File(imgPath);
    } else {
      return File('/storage/emulated/0');
    }
  } */

  @override
  void initState() {
    super.initState();

    //localfile();
  }

  @override
  Widget build(BuildContext context) {
    var colors = PrimaryColors();
    return Scaffold(
      backgroundColor: colors.shadeSide,
      appBar: AppBar(
        title: Text(
          'Affirm',
          style: TextStyle(
            color: colors.shade3,
            fontSize: 25,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: true,
        backgroundColor: colors.shadeSide,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.person_alt_circle_fill,
              color: colors.green,
              size: 35,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: colors.green,
              size: 35,
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.black12,
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        heroTag: 'big',
        backgroundColor: colors.shade1,
        elevation: 0.0,
        onPressed: () {
          Navigator.push(
            context,
            _createRoute(),
          );
        },
        child: const CustomButton(
          icon: Feather.mic,
          iconSize: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 0.0,
              shadowColor: colors.shade2,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: colors.shadeSide,
                  border: Border.all(
                    color: colors.shade3.withOpacity(0.45),
                    width: 1,
                  ),
                  //borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Play all',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: colors.shade3,
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          size: 30,
                          color: colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            ScaleFadePageTransition(
                              child: const PlayerPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 3,
                      shadowColor: colors.shade2,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: colors.shadeSide,
                          border: Border.all(
                            color: colors.shade1,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: colors.shade1,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(17),
                                          bottomLeft: Radius.circular(17),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text('${i + 1}.',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: colors.shade3,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('Title.......',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: colors.shade3,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FloatingActionButton(
                                heroTag: 'small${i + 1}',
                                backgroundColor: colors.shade1,
                                elevation: 0.0,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    ScaleFadePageTransition(
                                      child: PlayerPage(
                                        index: i + 1,
                                      ),
                                    ),
                                  );
                                },
                                child: CustomButton(
                                    icon: Icons.play_arrow_rounded,
                                    iconSize: 35,
                                    borderColor: colors.shadeSide
                                    //color: Colors.grey[200]!,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      opaque: false,
      barrierDismissible: false,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RecordingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var screenSize = MediaQuery.of(context).size;
        Offset center = Offset(-screenSize.width + 270, screenSize.height - 40);
        double beginRadius = 0.0;
        double endRadius = screenSize.height * 1.2;

        var tween = Tween(begin: beginRadius, end: endRadius);
        var radiusTweenAnimation = animation.drive(tween);

        return ClipPath(
          clipper: CircleRevealClipper(
              radius: radiusTweenAnimation.value, center: center),
          child: child,
        );
      },
    );
  }
}
