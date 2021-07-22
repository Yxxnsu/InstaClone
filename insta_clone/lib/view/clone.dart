/// Copyright 2020 Logica Booleana Authors

// Dependencias
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
// Los link de de las depedencias se pueden encontrar en "Más" => Dependencias
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Variables
const  List userList = [
  {
    "nombre": "Lucas ivan",
    "usuario": "aiivan3434",
    "live": false,
    "vista": false,
    "url_foto_perfil":"https://ichef.bbci.co.uk/news/640/cpsprodpb/153EB/production/_105191078_selfie1.jpg",
    "dashes": 1,
  },
  {
    "nombre": "Leonel Messi",
    "usuario": "leomessi10",
    "live": true,
    "vista": false,
    "url_foto_perfil":"https://pbs.twimg.com/media/B338156CIAAABM_.jpg",
    "dashes": 14,
    "url_image_post":"https://cdn.futbolargentino.com/sdi/2018/09/09/lionel-messi-y-su-mensaje-a-la-seleccion-argentina-via-instagram-669809.jpg",
  },
  {
    "nombre": "Leonela Ibañes",
    "usuario": "leonela21324",
    "live": true,
    "vista": false,
    "url_foto_perfil":"https://juanbustos.com/wp-content/uploads/2018/10/Selfie.jpg",
    "dashes": 2,
    "url_image_post":"https://mapio.net/images-p/1172789.jpg",
  },
  {
    "nombre": "Matia Cat",
    "usuario": "matieldm753",
    "live": false,
    "vista": false,
    "url_foto_perfil": "https://i.ytimg.com/vi/gLxO5R61hFI/maxresdefault.jpg",
    "dashes": 5,
    "url_image_post":"https://d35hsl9am8s2ta.cloudfront.net/public/images/2020/09/15991530940-La-Boca-773x458.jpg",
  },
  {
    "nombre": "Eugenia Suarez",
    "usuario": "eugedehuracan",
    "vista": false,
    "url_foto_perfil":
    "https://i.pinimg.com/564x/3b/e1/e5/3be1e5f82073d219df18ea2b09db1f3a.jpg",
    "dashes": 2,
    "url_image_post":"https://intainforma.inta.gob.ar/wp-content/uploads/2020/04/Agricultura_urbana-web.jpg",
  },
  {
    "nombre": "Jenifer Solange Urquiza",
    "usuario": "jeniurquiza2",
    "live": false,
    "vista": false,
    "url_foto_perfil":
    "https://i.pinimg.com/474x/77/56/06/775606b331fcb0a44dad916143bddf61.jpg",
    "dashes": 1,
    "url_image_post":"https://e00-marca.uecdn.es/assets/multimedia/imagenes/2019/06/09/15600711667471.png",
  },
  {
    "nombre": "Manuel Albastro",
    "usuario": "manualbastro93",
    "live": false,
    "vista": false,
    "url_foto_perfil":
    "https://www.okchicas.com/wp-content/uploads/2015/10/chico-transg%C3%A9nero-toma-una-selfie-cada-d%C3%ADa-4.jpg",
    "dashes":0,
    "url_image_post":"https://i.blogs.es/79fe25/traajos-en-programacion/1366_2000.jpg",
  },
  {
    "nombre": "Maria Lopez",
    "usuario": "mariilopez93",
    "live": false,
    "vista": false,
    "url_foto_perfil":
    "https://viapais.cdncimeco.com/media/cache/resolve/medium/http://viapais.com.ar/files/2017/10/20171020160548_30251308_0_body.jpg",
    "dashes":0,
    "url_image_post":"https://www.dzoom.org.es/wp-content/uploads/2007/02/canon-mejorar-fotografo-consejos-principiantes-novatos-810x540.jpg",
  },
];
bool isDark=false;
List<Color> colorGradientInstagram = [Color.fromRGBO(129, 52, 175, 1.0),Color.fromRGBO(129, 52, 175, 1.0),Color.fromRGBO(221, 42, 123, 1.0),Color.fromRGBO(254, 218, 119, 1.0)];

class PageListaInstagram extends StatefulWidget {
  @override
  _PageListaInstagramState createState() => _PageListaInstagramState();
}

class _PageListaInstagramState extends State<PageListaInstagram>with SingleTickerProviderStateMixin {

  // var
  RefreshController _refreshController =RefreshController(initialRefresh: false);

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // var
    isDark=Theme.of(context).brightness==Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: appbar(),
      body: body(context: context),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  // WIDGETS VIEWS
  PreferredSizeWidget appbar(){
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation:0.0,
      automaticallyImplyLeading: false,
      title: Text("Instagram", style: GoogleFonts.cookie(fontSize: 30.0,fontWeight:FontWeight.normal,color:Theme.of(context).iconTheme.color )),
      actions: <Widget>[
        IconButton(icon: FaIcon(Icons.send, size: 24.0),onPressed: () {},color: Theme.of(context).iconTheme.color )
      ],
    );
  }
  Widget  body({required BuildContext context}){

    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: 	ClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: (context,index)  => index==0?listViewHorizontalHistory(context: context):getPublicacion(index),
      ),
      );
  }
  Widget getPublicacion( int index ){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  DashedCircle(
                    dashes: userList[index]["dashes"],
                    gradientColor: colorGradientInstagram,
                    child: Padding(padding: EdgeInsets.all(3.0),child: CircleAvatar(backgroundColor: Theme.of(context).canvasColor,radius: 15.0,backgroundImage: NetworkImage( userList[index]["url_foto_perfil"]))),
                  ),
                  SizedBox(width: 10.0),
                  Text( userList[index]["nombre"],style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              IconButton(icon: Icon(Icons.more_vert),onPressed: null)
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            color: Colors.black12,
            child:CachedNetworkImage(fadeInDuration: Duration(milliseconds: 200),fit: BoxFit.cover,colorBlendMode:BlendMode.color,width: MediaQuery.of(context).size.width,imageUrl:userList[index]["url_image_post"]??"https://picsum.photos/500",placeholder: (context, urlImage) => Container(color: Colors.grey),errorWidget: (context, urlImage, error) => Center(child: Container(color: Colors.grey))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.heart),
                  SizedBox(width: 16.0),
                  Icon(FontAwesomeIcons.comment),
                  SizedBox(width: 16.0),
                  Icon(FontAwesomeIcons.paperPlane),
                ],
              ),
              Icon(FontAwesomeIcons.bookmark)
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),child: Text("Le gusto a _leslie23, y a 528 personas más",style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5.0),
          child: Row(
            children: [
              Text(userList[index]["usuario"],style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5.0,),
              Text("Que lindo",style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 25.0,width: 25.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.cover,image: NetworkImage( userList[index]["url_foto_perfil"])),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(child: TextField(decoration: InputDecoration(border: InputBorder.none,hintText: "Agregar un comentario...",hintStyle: TextStyle(fontSize: 14.0))),),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 1.0),child:Text("Hace 1 día", style: TextStyle(color: Colors.grey,fontSize: 11.0)))
      ],
    );
  }
  Widget listViewHorizontalHistory({required BuildContext context}) {

    double size = 120.0;

    return SizedBox(
      height: size,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return 
              index == 0 ? AddStory(size: size-40,context:context,person: userList[index])
                : userList[index]["live"]??false?LiveStoryCircle(size: size-40,color: Colors.purple,person:userList[index],colorCanvas:Theme.of(context).canvasColor)
                  : StoryCicle(person: userList[index],size: size-40);
          }
      ),
    );
  }
  Widget bottomNavigationBar( BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Theme.of(context).canvasColor),
      child: BottomNavigationBar(
        elevation: 10.0,showSelectedLabels: false,showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home, size: 24.0),label: ""),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.search, size: 24.0),label: ""),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.plusSquare, size: 24.0),label: ""),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart, size: 24.0),label: ""),
          BottomNavigationBarItem(icon: CircleAvatar( radius: 12.0,backgroundImage: NetworkImage( userList[0]["url_foto_perfil"] )) ,label:"Más"),
        ],
        currentIndex: 0,
        selectedItemColor: Theme.of(context).brightness==Brightness.dark?Colors.white:Colors.black,
        unselectedItemColor:Theme.of(context).brightness==Brightness.dark?Colors.white60:Colors.black54,
      ),
    );
  }
  // Function
  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)setState(() {});
    _refreshController.loadComplete();
  }
}

class AddStory extends StatelessWidget {

  AddStory( {required this.context,required this.person,this.size = 80.0} ) ;
  final  BuildContext context;
  final double size;
  final dynamic person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: size*0.95,height: size*0.95,
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(backgroundColor: Colors.grey[isDark?900:200],radius: 50.0,backgroundImage: NetworkImage(person["url_foto_perfil"])),
                ),
                Positioned(
                  right: size*0.08,bottom: size*0.08,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Theme.of(context).canvasColor,
                    child: CircleAvatar(foregroundColor: Colors.white,backgroundColor: Colors.blueAccent,radius: 8.5,child: Icon(Icons.add,size: 14.0,color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
          new SizedBox(height: 5.0),
          new Text("Tu historia",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

//  Dibujamos una circulo para representar una historia
const List<Color> _DefaultGradient = [Color.fromRGBO(129, 52, 175, 1.0)];
class StoryCicle extends StatelessWidget {
  
  StoryCicle({required this.person,this.size=80});
  final dynamic person;
  final double size;

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
                    width: size*0.95,height: size*0.95,
                    child: DashedCircle(
                      dashes: person["dashes"],
                      gradientColor: colorGradientInstagram,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(backgroundColor: Colors.grey[isDark?900:200],radius: 24.0,backgroundImage: NetworkImage(person["url_foto_perfil"])),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              new Text("${person["usuario"]}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center)
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

  DashedCircle({required this.child,this.dashes = 20,this.gradientColor = _DefaultGradient, this.gapSize = 3.0,this.strokeWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCirclePainter(gradientColor: gradientColor,dashes: dashes,gapSize: gapSize,strokeWidth: strokeWidth),
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

  _DashedCirclePainter({this.dashes = 0, this.gradientColor = _DefaultGradient,this.gapSize = 3.0,this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {

    final double gap = pi / 180 * gapSize;
    final double singleAngle = (pi * 2) / dashes;

    // crear un cuadrado delimitador, basado en el centro y el radio del arco
    Rect rect = new Rect.fromCircle(center: new Offset(165.0, 55.0),radius: 190.0);
    for (int i = 0; i < dashes; i++) {
      final Paint paint = Paint()
        ..shader = RadialGradient(colors: gradientColor).createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, gap + singleAngle * i,singleAngle - gap * 1, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCirclePainter oldDelegate) => dashes != oldDelegate.dashes;
}

//  CLASS: Dibujamos una circulo animado para representar un Vivo
class LiveStoryCircle extends StatefulWidget {

  const LiveStoryCircle({Key? key, required this.person, this.size=100.0,this.color=Colors.purple,this.colorCanvas=Colors.transparent}) : super(key: key);
  final double size;
  final Color color,colorCanvas;
  final dynamic person;

  @override
  _LiveStoryCircleState createState() => _LiveStoryCircleState();
}

class _LiveStoryCircleState extends State<LiveStoryCircle> with SingleTickerProviderStateMixin {
  
  // var
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
      color: widget.colorCanvas,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color:Colors.transparent,
                    margin: EdgeInsets.only(bottom: 5),
                    width: widget.size*0.95,height: widget.size*0.95,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: SpritePainter(animation: controller,sizePaint: widget.size),
                          child: Container(color: Colors.transparent,width: widget.size*0.70,height:  widget.size*0.70,child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.person["url_foto_perfil"]??"default") ,backgroundColor: Colors.transparent,)),
                        ),
                        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0),border: Border.all(color: widget.color, width: 2.0 ))),
                        
                      ],
                    ),
                  ),
                  Align(
                    alignment:Alignment.bottomCenter,
                    child: Container(
                      padding:EdgeInsets.all(5.0) ,
                      decoration: BoxDecoration(border: Border.all(color: widget.colorCanvas,width: widget.size*0.03),borderRadius: BorderRadius.circular(8),color: widget.color),
                      child: Text("VIVO",style: TextStyle(fontSize: widget.size*0.08,color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0,),
            new Text("${widget.person["usuario"]}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0),textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
// anim CustomPainter 
class SpritePainter extends CustomPainter {

  SpritePainter({required this.animation,this.sizePaint =100.0,this.color=Colors.purple}) : super(repaint: animation);
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