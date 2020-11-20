import 'package:bash_app/data/quote.dart';
import "package:http/http.dart" as http;
import "package:html/parser.dart";
import "package:html/dom.dart" as dom;

class Quotes {
  Quote quote = Quote();
  List<Quote> quotesData = List<Quote>();

  Future<void> getQuotes() async {
    final String url = 'https://bash.im/abyss/';
    dom.Document document = dom.Document();

    final response = await http.get(url);

    if (response.statusCode == 200) {
      document = parse(response.body);
    } else {
      throw Exception();
    }

    var quoteDocBody = document.getElementsByClassName('quote__body');
    var quoteDocNumber =
        document.getElementsByClassName('quote__header_permalink');

    // Вот тут список ок, заполнен данными
    for (int i = 0; i < quoteDocBody.length; i++) {
      quote.quoteNumber = quoteDocNumber[i].text;
      quote.quoteBody = quoteDocBody[i].text;
      quotesData.add(quote);
      quote = Quote();
    }
  }
}
