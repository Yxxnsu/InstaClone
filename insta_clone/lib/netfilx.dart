/// Copyright 2020 Logica Booleana Authors

// Dependencias
import 'package:flutter/material.dart';
// Los link de de las depedencias se pueden encontrar en "Más" => Dependencias
import 'package:cached_network_image/cached_network_image.dart';

class PagelistaNetflix extends StatefulWidget {
  PagelistaNetflixState createState() => new PagelistaNetflixState();
}

class PagelistaNetflixState extends State<PagelistaNetflix> {
  // var
  Color primatyColor = Colors.black;
  late Size screenSize;
  List listaPeliculas = [
    {
      "title": "El mundo oculto de Sabrina",
      "url":
          "https://www.lineupmx.com.mx/wp-content/uploads/2018/09/Sabrina.jpg"
    },
    {
      "title": "un viaje pesado",
      "url":
          "https://i2.wp.com/hiramnoriega.com/wp-content/uploads/2021/03/35435345345353543453.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://www.enter.co/wp-content/uploads/2019/03/Sabrina_Season_2_Vertical-Main_Localized_RGB_LAS-691x1024.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://i.pinimg.com/736x/b8/7a/a9/b87aa9d39089434e02cce9497e283661.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://www.accioncine.es/media/k2/items/cache/5b591a58cb6e9d0cf283871f39f87dd2_XL.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://pics.filmaffinity.com/resident_evil_extinction_resident_evil_3-571197761-large.jpg"
    },
    {
      "title": "pelicula",
      "url": "https://cdn.20m.es/img/2020/02/12/372/2152334.jpg"
    },
  ];
  List listaPeliculasOriginales = [
    {
      "title": "pelicula",
      "url":
          "https://i1.wp.com/hiramnoriega.com/wp-content/uploads/2021/01/234234432432442423.jpg"
    },
    {
      "title": "pelicula",
      "url": "https://i.blogs.es/3c0b3a/vertical-2_pre/450_1000.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://1.bp.blogspot.com/-Ek6lNZp9fa8/X56khsv4zFI/AAAAAAABUdQ/hc23I5ODwUkmE_PghqFzY_xsNNq6k_rngCLcBGAsYHQ/s592/cielo-de-medianoche-poster.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://www.cartelera.com.uy/imagenes_espectaculos/moviedetail13/23809.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://i.pinimg.com/originals/81/2f/9e/812f9e863a8a70068335428c4a76e060.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://pics.filmaffinity.com/Big_Mouth_Serie_de_TV-134591616-large.jpg"
    },
  ];
  List listaPeliculasTendencias = [
    {
      "title": "pelicula",
      "url":
          "https://i1.wp.com/hiramnoriega.com/wp-content/uploads/2021/01/234234432432442423.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://i1.wp.com/hiramnoriega.com/wp-content/uploads/2021/01/234234432432442423.jpg"
    },
    {
      "title": "pelicula",
      "url": "https://i.blogs.es/3c0b3a/vertical-2_pre/450_1000.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://1.bp.blogspot.com/-Ek6lNZp9fa8/X56khsv4zFI/AAAAAAABUdQ/hc23I5ODwUkmE_PghqFzY_xsNNq6k_rngCLcBGAsYHQ/s592/cielo-de-medianoche-poster.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://pics.filmaffinity.com/Big_Mouth_Serie_de_TV-134591616-large.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://www.cartelera.com.uy/imagenes_espectaculos/moviedetail13/23809.jpg"
    },
    {
      "title": "pelicula",
      "url":
          "https://pics.filmaffinity.com/Big_Mouth_Serie_de_TV-134591616-large.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    primatyColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Theme.of(context).canvasColor;

    return new Scaffold(
      backgroundColor: primatyColor,
      body: body(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  /// WIDGETS VIEWS
  CustomScrollView body() {
    return CustomScrollView(slivers: <Widget>[sliverAppBar(), sliverList()]);
  }

  SliverAppBar sliverAppBar() {
    // Creamos un appBar expandido al %62 que se esconde al desplazarce
    return new SliverAppBar(
      backgroundColor: primatyColor,
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                height: 35,
                width: 20,
                child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Netflix_2015_N_logo.svg/1200px-Netflix_2015_N_logo.svg.png")),
            _buildAppBarText("Program"),
            _buildAppBarText("Personal"),
            _buildAppBarText("My iist"),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: screenSize.height * 0.62,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(listaPeliculas[0]["url"], fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Colors.transparent, primatyColor],
                    stops: [0.2, 0.8]),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  child: Text(
                    listaPeliculas[0]["title"],
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Surrealista"),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.radio_button_checked,
                            color: Colors.blueAccent, size: 8.0)),
                    Text("Provocador"),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.radio_button_checked,
                            color: Colors.blueAccent, size: 8.0)),
                    Text("Misterio"),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.radio_button_checked,
                            color: Colors.blueAccent, size: 8.0)),
                    Text("Emotivo"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {},
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add,
                                      size: 24.0,
                                    ),
                                    Text("Mi lista",
                                        style: TextStyle(fontSize: 10.0))
                                  ]))),
                      // TODO:  Update
                      Expanded(
                          child: RaisedButton.icon(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                        label: Text(
                          "Reproducir",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white),
                        ),
                        onPressed: () {},
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )),
                      Expanded(
                          child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {},
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.info_outline,
                                      size: 24.0,
                                    ),
                                    Text("Más información",
                                        style: TextStyle(fontSize: 10.0))
                                  ]))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBarText(String title) {
    return Text(title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16));
  }

  SliverList sliverList() {
    // Una astilla que coloca múltiples hijos de caja en una matriz lineal a lo largo del eje principal. */
    // Creamos una lista con widgets que queresmos mostrar*/
    List list = [
      listHorizontalCards(title: "Mis lista", listPeliculas: listaPeliculas),
      listHorizontalCardsGrande(
          title: "Titulos Originales", listPeliculas: listaPeliculasOriginales),
      listHorizontalCards(
          title: "Tendencias", listPeliculas: listaPeliculasTendencias),
      listHorizontalCards(
          title: "Nuevos lanzamientos", listPeliculas: listaPeliculas),
    ];
    return SliverList(
      // Para ello, se utiliza un delegado para crear elementos a medida que se desplazan por la pantalla. */
      delegate: SliverChildBuilderDelegate((context, index) => list[index],
          childCount: list.length),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return new BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(label: "Inicio", icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "Próximamente", icon: Icon(Icons.play_circle_filled)),
        BottomNavigationBarItem(
            label: "Descargas", icon: Icon(Icons.file_download)),
      ],
      currentIndex: 0,
      onTap: (index) {},
    );
  }

  Widget listHorizontalCardsGrande(
      {required String title, required List listPeliculas}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 12.0, top: 25.0, left: 12.0, right: 20.0),
          child: Text(title,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: double.infinity,
          height: 350.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listPeliculas.length,
            itemBuilder: (context, index) =>
                cardItemPeliculaExtend(url: listPeliculas[index]["url"]),
          ),
        ),
      ],
    );
  }

  Widget listHorizontalCards(
      {required String title, required List listPeliculas}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 12.0, top: 25.0, left: 12.0, right: 20.0),
          child: Text(title,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        Container(
          width: double.infinity,
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listPeliculas.length,
            itemBuilder: (context, index) =>
                cardItemPelicula(url: listPeliculas[index]["url"]),
          ),
        ),
      ],
    );
  }

  /// WIDGETS COMPONENTS
  Widget cardItemPelicula({required String url}) {
    return Card(
      margin: const EdgeInsets.all(3.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
        child: Container(
          width: 140.0,
          child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 200),
              fit: BoxFit.cover,
              imageUrl: url,
              placeholder: (context, urlImage) => Container(color: Colors.grey),
              errorWidget: (context, urlImage, error) =>
                  Center(child: Container(color: Colors.grey))),
        ),
      ),
    );
  }

  Widget cardItemPeliculaExtend({required String url}) {
    return Card(
      margin: const EdgeInsets.all(3.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
          width: 170.0,
          child: CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, urlImage) => Container(color: Colors.grey),
            errorWidget: (context, urlImage, error) =>
                Center(child: Container(color: Colors.grey)),
          )),
    );
  }
}
