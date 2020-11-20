import 'package:bash_app/data/quote.dart';
import 'package:bash_app/data/quotes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        // centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Bash',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            ' Im<-',
            style: TextStyle(color: Colors.yellow[900]),
          )
        ]),
      ),
      body: BodyHomeScreen(),
    );
  }
}

class BodyHomeScreen extends StatefulWidget {
  BodyHomeScreen({Key key}) : super(key: key);

  @override
  _BodyHomeScreenState createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  List<Quote> listQuotes = List<Quote>();

  bool _loading = true;

  void getQuotes() async {
    Quotes quotes = Quotes();
    await quotes.getQuotes();
    listQuotes = quotes.quotesData;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 7.5,
                ),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listQuotes.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(listQuotes[index].quoteNumber),
                          subtitle: Text(listQuotes[index].quoteBody),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
