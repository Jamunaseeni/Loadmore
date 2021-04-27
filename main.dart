import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoadMore_Example',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List dummylist;
  ScrollController _scrollController = ScrollController();
  int _currentmax = 10;
  @override
  void initState() {
    super.initState();
    dummylist = List.generate(_currentmax, (index) => "Item : ${index + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _getMoreList();
    });
  }

  _getMoreList() {
    print("Get More List");
    for (int i = _currentmax; i < _currentmax + 10; i++) {
      dummylist.add("Item : ${i + 1}");
    }
    _currentmax = _currentmax + 10;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoadMore_Example'),
        centerTitle: true,
        backgroundColor: Colors.lime,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemExtent: 60,
        itemBuilder: (context, index) {
          if (index == dummylist.length) {
            return CupertinoActivityIndicator();
          }
          return ListTile(
            title: Text(dummylist[index]),
          );
        },
        itemCount: dummylist.length + 1,
      ),
    );
  }
}
