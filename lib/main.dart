import 'package:expenses_app/graph_widget.dart';
import 'package:expenses_app/month_widget.dart';
import 'package:flutter/material.dart';
import  'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Tracker',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Expenses tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  PageController _pageController;
  int currentPage=9;
  Stream<QuerySnapshot> _query;


  @override
  void initState(){
    super.initState();

    _query= Firestore.instance
        .collection('expenses')
        .where("Month", isEqualTo: currentPage+1)
        .snapshots();

    _pageController = PageController(
      initialPage:9,
      viewportFraction: 0.4,

    );
  }

  Widget _botomAction(IconData icon){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Icon(icon),
        onTap:() {

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8.0,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                  _botomAction(FontAwesomeIcons.history),
                  _botomAction(FontAwesomeIcons.chartPie ),
                  SizedBox(width: 32.0,),
                  _botomAction(FontAwesomeIcons.wallet),
                  _botomAction(Icons.settings)

              ],
            ),
          ),
        floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add),
          onPressed: (){

          },
        ),
        body: _body(),
      );
  }

  Widget _body(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          StreamBuilder<QuerySnapshot>(
            stream: _query,
            builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot>  data){
              if(data.hasData){
                return MonthWidget(
                  documents: data.data.documents,
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

            },
          ),



        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector(){
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage){
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _pageController,
        children: <Widget>[
          _pageItem("January",0),
          _pageItem("February",1),
          _pageItem("March",2),
          _pageItem("April",3),
          _pageItem("May",4),
          _pageItem("June",5),
          _pageItem("July",6),
          _pageItem("August",7),
          _pageItem("September",8),
          _pageItem("October",9),
          _pageItem("November",10),
          _pageItem("December",11)
        ],

      ),
    );
  }









}
