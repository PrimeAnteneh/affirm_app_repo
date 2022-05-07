import 'package:affirm/Frontend/shared_styles.dart';
import 'package:affirm/Frontend/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlayerPage extends StatefulWidget {
  final int? index;
  const PlayerPage({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  double value = 0;
  double min = 0;
  double max = 10;
  late AnimationController aniController;
  late double scale1 = 0.1;
  late double scale2 = 1;
  late Animation _animation;
  bool isCollapsed = false;
  ScrollController scController = ScrollController();
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late double borderRadius;
  void openDrawer() => setState(() {
        isCollapsed = false;
        scaleFactor = 1;
        borderRadius = 30;
      });
  void closeDrawer() => setState(() {
        isCollapsed = true;
        scaleFactor = 1;
        borderRadius = 0;
      });
  @override
  void initState() {
    super.initState();
    closeDrawer();
    aniController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _animation = Tween(begin: 5.0, end: 10.0).animate(
      CurvedAnimation(parent: aniController, curve: Curves.easeOut),
    );

    //aniController.repeat(reverse: true);
    /* aniController.addListener(() {
      if (aniController.isCompleted) {
        aniController.reverse();
      }
      if (aniController.isDismissed) {
        aniController.forward();
      }
    }); */
  }

  @override
  void dispose() {
    aniController.dispose();
    super.dispose();
  }

  bool play = true;
  bool repeat1 = false;
  bool repeatAll = false;
  bool shuffle = false;
  double targetValue = 24;

  IconData repeateState() {
    if (repeat1) {
      return CupertinoIcons.repeat_1;
    } else if (repeatAll) {
      return CupertinoIcons.repeat;
    } else {
      return CupertinoIcons.repeat;
    }
  }

  List list = ['one', 'Two', 'Three', 'Four', 'Five'];
  bool reordering = false;

  @override
  Widget build(BuildContext context) {
    var colors = PrimaryColors();
    double width = MediaQuery.of(context).size.width;
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
          title: Text(
            'Now playing',
            style: TextStyle(
              color: colors.shadeSide,
              fontSize: 25,
              fontFamily: 'Serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.white24,
          ),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (!isCollapsed) {
                  closeDrawer();
                }
              },
              child: AbsorbPointer(
                absorbing: !isCollapsed,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: width / 1.3,
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, _) {
                          return Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: colors.shade1,
                              boxShadow: const [
                                /* for (int i = 1; i <= 4; i + 2)
                                    BoxShadow(
                                      color: Colors.white38
                                          .withOpacity(aniController.value / 3 + 0.3),
                                      spreadRadius: _animation.value * i + 10,
                                    ) */
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.white70,
                                  Colors.white10,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: colors.shade1,
                                width: 7,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      'Recording_${widget.index ?? 0}',
                      style: TextStyle(
                        fontSize: 20,
                        color: colors.shadeSide,
                      ),
                    ),
                    Container(
                      height: 68,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${DateTime.now().hour} : ${DateTime.now().add(Duration(
                                        minutes: value.toInt(),
                                      )).minute}',
                                  style: TextStyle(
                                    color: colors.shadeSide,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${DateTime.now().hour} : ${DateTime.now().add(Duration(
                                        minutes: max.toInt(),
                                      )).subtract(Duration(
                                        minutes: value.toInt(),
                                      )).minute}',
                                  style: TextStyle(
                                    color: colors.shadeSide,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Slider(
                            value: value,
                            min: min,
                            max: max,
                            label:
                                '${DateTime.now().hour} : ${DateTime.now().minute}',
                            onChanged: (double newValue) {
                              setState(() {
                                Duration(minutes: newValue.toInt() + 1);
                                value = newValue;
                              });
                            },
                            activeColor: colors.shade3,
                            inactiveColor: colors.shade1,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            if (!repeatAll) {
                              setState(() {
                                repeatAll = true;
                              });
                            } else if (repeatAll && !repeat1) {
                              setState(() {
                                repeat1 = true;
                              });
                            } else {
                              setState(() {
                                repeat1 = false;
                                repeatAll = false;
                              });
                            }
                          },
                          icon: Icon(
                            repeateState(),
                            size: 30,
                            color: repeat1 || repeatAll
                                ? colors.shade1
                                : colors.shade3,
                          ),
                        ),
                        FloatingActionButton.small(
                          heroTag: 'prevBtn',
                          backgroundColor: colors.shade2,
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          onPressed: () {},
                          splashColor: colors.shade3,
                          child: CustomButton(
                            gradientColor1: Colors.transparent,
                            gradientColor2: Colors.transparent,
                            icon: Icons.skip_previous_rounded,
                            iconSize: 30,
                            borderColor: colors.shadeSide,
                            borderSize: 2,
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: 'playBtn',
                          backgroundColor: colors.shade1,
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          onPressed: () {
                            if (!play) {
                              setState(() {
                                play = true;
                              });
                            } else {
                              setState(() {
                                play = false;
                              });
                            }
                          },
                          child: CustomButton(
                            icon: play
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            iconSize: 35,
                            borderColor: colors.shadeSide,
                            borderSize: 3,
                            gradientColor1: play ? colors.blue : colors.green,
                            gradientColor2: play ? colors.green : colors.blue,
                          ),
                        ),
                        FloatingActionButton.small(
                          heroTag: 'nextBtn',
                          backgroundColor: colors.shade2,
                          elevation: 0.0,
                          highlightElevation: 0.0,
                          onPressed: () {},
                          splashColor: colors.shade3,
                          child: CustomButton(
                            gradientColor1: Colors.transparent,
                            gradientColor2: Colors.transparent,
                            icon: Icons.skip_next_rounded,
                            iconSize: 30,
                            borderColor: colors.shadeSide,
                            borderSize: 2,
                          ),
                        ),
                        IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            if (!shuffle) {
                              setState(() {
                                shuffle = true;
                              });
                            } else {
                              setState(() {
                                shuffle = false;
                              });
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.shuffle,
                            size: 30,
                            color: shuffle ? colors.shade1 : colors.shade3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragStart: (_) {
                  if (isCollapsed) {
                    openDrawer();
                  } else {
                    closeDrawer();
                  }
                },
                /*  onVerticalDragEnd: (dr) {
                  closeDrawer();
                }, */
                child: AnimatedContainer(
                  height: isCollapsed ? width / 6.55 : width * 1.7,
                  width: width,
                  decoration: BoxDecoration(
                    color: colors.shade1,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  curve: Curves.easeIn,
                  transform: Matrix4.translationValues(
                    0,
                    0,
                    scaleFactor,
                  )..scale(
                      scaleFactor,
                    ),
                  child: Column(
                    children: [
                      Container(
                        height: width / 6.55,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  !isCollapsed ? colors.shade3 : colors.shade1,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: !isCollapsed ? closeDrawer : openDrawer,
                          enabled: true,
                          focusColor: colors.shade2,
                          leading: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.queue_music_outlined,
                              size: 35,
                              color: colors.blue,
                            ),
                          ),
                          title: Text(
                            'Title...${list[0]}',
                            style: TextStyle(
                              fontSize: 17,
                              color: colors.shade3,
                            ),
                          ),
                          trailing: Text(
                            '00:30',
                            style: TextStyle(
                              fontSize: 17,
                              color: colors.shade3,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ReorderableListView.builder(
                          onReorder: (oldIndex, newIndex) => setState(() {
                            reordering = true;
                            var index =
                                newIndex > oldIndex ? newIndex - 1 : newIndex;
                            var elem = list.removeAt(oldIndex);
                            list.insert(index, '$elem');
                            reordering = false;
                          }),
                          itemCount: list.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              key: ValueKey('$i'),
                              onTap: !isCollapsed ? closeDrawer : openDrawer,
                              enabled: true,
                              focusColor: colors.shade2,
                              leading: Icon(
                                Icons.menu,
                                size: reordering ? 18 : 25,
                                color:
                                    reordering ? colors.green : colors.shade2,
                              ),
                              title: Text(
                                'Title...${list[i]}',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: colors.shade3,
                                ),
                              ),
                              trailing: Text(
                                '00:30',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: colors.shade3,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
