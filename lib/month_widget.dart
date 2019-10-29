import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expenses_app/graph_widget.dart';

class MonthWidget extends StatefulWidget{

  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;

   MonthWidget({Key key, this.documents}) :
         total = documents.map((doc) => doc['Value'])
             .fold(0.0, (a, b) => a + b),
         perDay = List.generate(31, (int index) {
           return documents.where((doc) => doc['Day'] == (index + 1))
               .map((doc) => doc['Value'])
               .fold(0.0, (a, b) => a + b);
         }),
         categories = documents.fold({}, (Map<String, double> map, document) {
           if (!map.containsKey(document['Category'])) {
             map[document['Category']] = 0.0;
           }

           map[document['Category']] += document['Value'];
           return map;
         }),
        super(key: key);


  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Column(
        children: <Widget>[
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


  Widget _expenses(){
    return Column(
      children: <Widget>[
        Text("\$${widget.total.toStringAsFixed(2)}" , style:
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

  Widget _graph(){
    return Container(
        height: 180.0,
        child: GraphWidget(perDay: widget.perDay));
  }

  Widget _addItem(IconData icon, String title, int percent,  double price){
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
          subtitle:  Text("$percent%  of expenses", style:
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
      child: ListView.separated(
        itemCount: widget.categories.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categories.keys.elementAt(index);
          var data = widget.categories[key];
          return _addItem(FontAwesomeIcons.shoppingCart, key, 100 * data ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }
}