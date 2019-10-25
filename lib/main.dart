import 'package:expenses_app/graph_widget.dart';
import 'package:flutter/material.dart';
import  'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  void initState(){
    super.initState();
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
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),
          _list(),


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

  Widget _graph(){
    return Container(
        height: 180.0,
        child: GraphWidget());
  }

  Widget _addItem(IconData icon, String title, String percent, String price){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(icon),
          title: Text(title, style:
            TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle:  Text("$percent of expenses", style:
            TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.0
            )
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$$price",style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,

              ),),
            ),
          ),
        ),
        Container(
          color: Colors.blueAccent.withOpacity(0.15),
          height: 4.0,
        ),
      ],

    );
  }

  Widget _list(){
    return Expanded(
      child: ListView(
        children: <Widget>[

          _addItem(FontAwesomeIcons.shoppingCart,"Shopping", "14%", "145.12"),
          _addItem(FontAwesomeIcons.glassMartini,"Alcohol", "5%", "73.24"),
          _addItem(Icons.fastfood,"Fast food", "10%", "101.58"),
          _addItem(Icons.account_balance_wallet,"Bills", "55%", "958.78"),
          _addItem(FontAwesomeIcons.tshirt,"Clothes", "35%", "350.55"),
          _addItem(FontAwesomeIcons.heart,"Relashionship", "12%", "73.24"),
          _addItem(FontAwesomeIcons.clinicMedical,"Health care", "14%", "80.14"),
        ],
      ),
    );
  }


  Widget _expenses(){
    return Column(
      children: <Widget>[
        Text("\$2361.41" , style:
          TextStyle(
            fontSize:30.0,
            fontWeight: FontWeight.bold
          ),
        ),
        Text("Total expenses" , style:
          TextStyle(
             fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color:  Colors.blueGrey
          ),
        )


      ],
    );
  }
}
