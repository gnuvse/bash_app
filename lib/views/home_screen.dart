import 'package:bash_app/data/quote.dart';
import 'package:bash_app/data/quotes.dart';
import 'package:flutter/material.dart';

Color orangeColor = Colors.yellow[900];

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
            style: TextStyle(color: orangeColor),
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
  List<Quote> _listQuotes = List<Quote>();

  bool _loading = true;

  String _url = "https://bash.im/abyss";
  String _urlWantMore;

  void getQuotes(_url) async {
    Quotes quotes = Quotes(url: _url);
    await quotes.getQuotes();
    _listQuotes = quotes.quotesData;
    //delete string 'abyss', for example /abyss?23763 -> ?23763

    _urlWantMore = quotes.linkOnNextPage.substring(6);

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getQuotes(_url);
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
                  // key: ObjectKey(_listQuotes[0]),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listQuotes.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(_listQuotes[index].quoteNumber),
                          subtitle: Text(_listQuotes[index].quoteBody),
                        ),
                      ),
                    );
                  },
                ),
                RaisedButton(
                    onPressed: () {
                      String newUrl = "$_url$_urlWantMore";
                      setState(() {
                        getQuotes(newUrl);
                      });
                    },
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Want'),
                        Text(
                          ' more->',
                          style: TextStyle(color: orangeColor),
                        ),
                      ],
                    )),
              ],
            ),
          );
  }
}

// String parseForWantMore() {
//   dom.Document document = dom.Document();

//   return newUrl;
// }
