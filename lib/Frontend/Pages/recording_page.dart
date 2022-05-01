import 'package:affirm/Frontend/Pages/home_page.dart';
import 'package:affirm/Frontend/Pages/player_page.dart';
import 'package:affirm/Frontend/Utilities/custom_page_transition.dart';
import 'package:affirm/Frontend/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({Key? key}) : super(key: key);

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController aniController;
  bool isplaying = true;
  bool stop = false;
  @override
  void initState() {
    super.initState();
    aniController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1700,
      ),
    );
    _animation = Tween(begin: 8.0, end: 12.0).animate(
      CurvedAnimation(parent: aniController, curve: Curves.easeIn),
    );
    aniController.addListener(() {
      if (aniController.isCompleted && isplaying) {
        aniController.repeat();
      } else if (aniController.isAnimating && !isplaying && !stop) {
        aniController.stop();
      } else if (stop && aniController.isAnimating && isplaying) {
        aniController.reset();
      } else if (!stop && aniController.isCompleted && isplaying) {
        aniController.repeat();
      }
      /*  if (aniController.isDismissed) {
        aniController.forward();
      } */
    });
  }

  @override
  void dispose() {
    aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colors = PrimaryColors();
    double width = MediaQuery.of(context).size.width;
    aniController.forward();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.green,
            colors.blue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: colors.shadeSide,
            size: 20,
          ),
          title: RichText(
            text: TextSpan(
                text: 'Recording',
                style: TextStyle(
                  color: colors.shadeSide,
                  fontSize: 25,
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
                children: const [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: /*  FadeTransition(
                        opacity: Tween<double>(
                          begin: 1.0,
                          end: 0.0,
                        ).animate(aniController),
                        child: const */
                          Icon(
                        Icons.fiber_manual_record,
                        size: 30,
                        color: Colors.red,
                      ),
                      //),
                    ),
                  )
                ]),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.white24,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Feather.mic,
                        size: 65,
                        color: colors.green,
                      ),
                    ),
                    for (int i = 2; i <= 5; i++)
                      Center(
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.5,
                            end: 1.0,
                          ).animate(aniController),
                          child: FadeTransition(
                            opacity: Tween<double>(
                              begin: 0.7,
                              end: 0.0,
                            ).animate(aniController),
                            child: Container(
                              height: 75 * i.toDouble(),
                              width: 75 * i.toDouble(),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                                    .withOpacity((i / _animation.value) + 0.36),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(95),
                      bottomRight: Radius.circular(95),
                    ),
                    highlightColor:
                        !isplaying ? Colors.amberAccent : colors.shade3,
                    onTap: () {
                      if (!isplaying) {
                        setState(() {
                          isplaying = true;
                        });
                        if (stop && isplaying) {
                          aniController.repeat();
                          setState(() {
                            stop = false;
                          });
                        }
                      } else {
                        setState(() {
                          isplaying = false;
                        });
                      }
                    },
                    child: Container(
                      height: 105,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(95),
                          bottomRight: Radius.circular(95),
                        ),
                        border: Border.all(
                          color: Colors.white70,
                          width: 3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Icon(
                          isplaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 40,
                          color:
                              !isplaying ? Colors.amberAccent : colors.shade3,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(95),
                      bottomLeft: Radius.circular(95),
                    ),
                    highlightColor: stop ? Colors.red : colors.shade3,
                    onTap: () {
                      if (!stop) {
                        setState(() {
                          stop = true;
                          isplaying = false;
                        });
                      }
                    },
                    child: Container(
                      height: 105,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(95),
                          bottomLeft: Radius.circular(95),
                        ),
                        border: Border.all(
                          color: Colors.white70,
                          width: 3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Icon(
                          Icons.stop,
                          size: 40,
                          color: stop ? Colors.red : colors.shade3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: width / 10),
              height: 45,
              width: 270,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
                border: Border.all(
                  color: Colors.white70,
                  width: 3,
                ),
              ),
              child: Center(
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200),
                  ),
                  highlightColor: colors.green,
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: colors.shade3,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
