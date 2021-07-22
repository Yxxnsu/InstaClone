import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_clone/service/controller.dart';

import 'package:insta_clone/model/dummyRepo.dart';

import 'mypage.dart';

List<Color> colorGradientInstagram = [
  Color.fromRGBO(129, 52, 175, 1.0),
  Color.fromRGBO(129, 52, 175, 1.0),
  Color.fromRGBO(221, 42, 123, 1.0),
  Color.fromRGBO(254, 218, 119, 1.0)
];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  
  final textStyle = TextStyle(color: Colors.black);
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final stateController controller = Get.put(stateController());

  List<Widget> pageList = [
    HomePage(),
    MyPage(),
  ];


  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: appBar(),
      body: body(context),      
    );
  }

  appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      automaticallyImplyLeading: false,
      title: Text(
        'Instagram',
        style: GoogleFonts.cookie(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
      actions: [
        Center(
          child: FaIcon(
            Icons.send, 
            color: Colors.black
          ),
        ),
      ],
    );
  }

  body(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dummyList.length,
        itemBuilder: (context, index) => index == 0
            ? _buildProfileCircle(context)
            : _buildStoryList(context, index),
      ),
    );
  }

  _buildProfileCircle(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dummyList.length,
        itemBuilder: (context, index) => index == 0
          ? addStory(context)
          : dummyList[index]["live"]
            ? LiveCircle(context: context, person: dummyList[index])
            : profileCircle(context: context, person: dummyList[index], size: 80),
      ),
    );
  }

  _buildStoryList(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  DashedCircle(
                    dashes: dummyList[index]["dashes"],
                    gradientColor: colorGradientInstagram,
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).canvasColor,
                        radius: 15.0,
                        backgroundImage: NetworkImage(dummyList[index]["profileURL"]))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(dummyList[index]["name"],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          color: Colors.black12,         
          child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 200),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.color,
              width: MediaQuery.of(context).size.width,
              imageUrl: dummyList[index]["url_image_post"] ?? "https://picsum.photos/500",
              placeholder: (context, urlImage) => Container(color: Colors.grey),
              errorWidget: (context, urlImage, error) => CircularProgressIndicator(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.heart),
                    SizedBox(width: 16.0),
                    Icon(FontAwesomeIcons.comment),
                    SizedBox(width: 16.0),
                    Icon(FontAwesomeIcons.paperPlane),
                  ],
                ),
              ),
              Icon(FontAwesomeIcons.bookmark)
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("왜 이랭 이거", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          child: Row(
            children: [
              Text(
                dummyList[index]["userId"],
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "다했댱", 
                style: TextStyle(
                  fontWeight: FontWeight.normal
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(dummyList[index]["profileURL"])),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "댓글을 입력해주세요...",
                        hintStyle: TextStyle(fontSize: 14.0))),
              ),
            ],
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
            child: Text("댓글 1개",
                style: TextStyle(color: Colors.grey, fontSize: 11.0)))
      ],
    );
  }

  Widget addStory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipOval(
                child: Container(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    dummyList[0]["profileURL"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 80 * 0.08,
                bottom: 80 * 0.08,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).canvasColor,
                  child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.add, size: 14.0, color: Colors.white)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dummyList[0]["userId"],
            style: textStyle.copyWith(fontSize: 10),
          )
        ],
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}

const List<Color> _DefaultGradient = [Color.fromRGBO(129, 52, 175, 1.0)];

class profileCircle extends StatefulWidget {
  final BuildContext context;
  final double size;
  final dynamic person;
  const profileCircle({
    Key? key,
    required this.context,
    this.size = 40,
    required this.person,
  }) : super(key: key);

  @override
  _profileCircleState createState() => _profileCircleState();
}

class _profileCircleState extends State<profileCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 80 * 0.95,
                    height: 80 * 0.95,
                    child: DashedCircle(
                      dashes: widget.person["dashes"],
                      gradientColor: colorGradientInstagram,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 24.0,
                            backgroundImage:
                              NetworkImage(widget.person["profileURL"])),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text("${widget.person["userId"]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.center
              ),
            ]
          )
    );
  }
}

class DashedCircle extends StatelessWidget {
  // var
  final int dashes;
  final List<Color> gradientColor;
  final double gapSize;
  final double strokeWidth;
  final Widget child;

  DashedCircle(
    {
      required this.child,
      this.dashes = 20,
      this.gradientColor = _DefaultGradient,
      this.gapSize = 3.0,
      this.strokeWidth = 2.0
    }
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCirclePainter(
          gradientColor: gradientColor,
          dashes: dashes,
          gapSize: gapSize,
          strokeWidth: strokeWidth),
      child: child,
    );
  }
}

// CustomPainter
class _DashedCirclePainter extends CustomPainter {
  final int dashes;
  final List<Color> gradientColor;
  final double gapSize;
  final double strokeWidth;

  _DashedCirclePainter(
    {
      this.dashes = 0,
      this.gradientColor = _DefaultGradient,
      this.gapSize = 3.0,
      this.strokeWidth = 2.0
    }
  );

  @override
  void paint(Canvas canvas, Size size) {
    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    // crear un cuadrado delimitador, basado en el centro y el radio del arco
    Rect rect =
        new Rect.fromCircle(center: new Offset(165.0, 55.0), radius: 190.0);
    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..shader = RadialGradient(colors: gradientColor).createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, gap + singleAngle * i, singleAngle - gap * 1, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter oldDelegate) => dashes != oldDelegate.dashes;
}

class LiveCircle extends StatefulWidget {
  final BuildContext context;
  final dynamic person;
  const LiveCircle({
    Key? key,
    required this.context,
    required this.person,
  }) : super(key: key);

  @override
  _LiveCircleState createState() => _LiveCircleState();
}

class _LiveCircleState extends State<LiveCircle> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    _startAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(period: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(bottom: 5),
                    width: 80 * 0.95,
                    height: 80 * 0.95,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: SpritePainter(
                              animation: controller, sizePaint: 80),
                          child: Container(
                            color: Colors.transparent,
                            width: 80 * 0.70,
                            height: 80 * 0.70,
                            child: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  widget.person["profileURL"] ??"default"),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border:
                                Border.all(color: Colors.purple, width: 2.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).canvasColor,
                              width: 80 * 0.03),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple),
                      child: Text(
                        "RIVE",
                        style:
                            TextStyle(fontSize: 80 * 0.08, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "${widget.person["userId"]}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0),
              textAlign: TextAlign.center
              )
          ],
        ),
      ),
    );
  }
}

class SpritePainter extends CustomPainter {
  SpritePainter(
      {required this.animation,
      this.sizePaint = 100.0,
      this.color = Colors.purple})
      : super(repaint: animation);
  final Animation<double> animation;
  final double sizePaint;
  final Color color;

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(.0, 1.0);
    Color color = this.color.withOpacity(opacity);

    double size = this.sizePaint / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
