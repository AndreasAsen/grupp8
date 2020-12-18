import 'package:flutter/material.dart';
import 'package:grupp_8/api.dart';
import 'aboutUs_screen.dart';
import 'api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final TextEditingController imageSearch = new TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            child: CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: MySliverAppBar(expandedHeight: 350),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.black,
          ),
        )
      ],
    )));
  }

  Widget _photoListView() {
    return FutureBuilder<List<Photo>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _listViewBuilder(snapshot.data);
          }
          return _listViewBuilder([]);
        });
  }

  Widget _listViewBuilder(List<Photo> list) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Image.network(
          list[index].photoUrl,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _testPhoto() {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _testPhoto2() {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1608228069492-3babaaba6f4c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          child: Container(
            width: double.infinity,
            color: Color.fromARGB(255, 86, 75, 83),
          ),
        ),
        Positioned(
          top: -shrinkOffset,
          child: IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => (AboutUs())),
                );
              }),
        ),
        Positioned(
          top: 14 - shrinkOffset,
          right: 90,
          child: _logoText(),
        ),
        Positioned(
          top: -shrinkOffset,
          right: 0,
          child: IconButton(
              icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: _searchImageTextField(),
            ),
          ],
        ),
        Positioned(
          top: 50 - shrinkOffset,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              child: _testPhoto(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _appBar(context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.info, color: Colors.white),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (AboutUs())),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ]);
  }

  Widget _photoView() {
    return FutureBuilder<Photo>(
        future: fetchRandomFeaturedPhoto(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _topImage(snapshot.data);
          }
          return _topImage(new Photo());
        });
  }

  Widget _testPhoto() {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _topImage(Photo photo) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(photo.photoUrl), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.4),
            Colors.black.withOpacity(.2),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                (photo.user.toUpperCase()),
                style: TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchImageTextField() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: TextField(
        style: TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.bottom,
        controller: imageSearch,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30, width: 2)),
            hintText: "Search..",
            hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Widget _logoText() {
    return Text(
      'PLENTY OF PICS',
      style: TextStyle(
          // shadows: <Shadow>[
          //   Shadow(
          //     offset: Offset(1.0, 1.0),
          //     blurRadius: 3.0,
          //     color: Color.fromARGB(255, 0, 0, 0),
          //   )
          // ],
          color: Color.fromARGB(255, 225, 255, 255),
          fontSize: 22,
          fontFamily: "Syncopate"),
    );
  }
}
