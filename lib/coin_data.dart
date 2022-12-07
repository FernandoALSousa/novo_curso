import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '9B291EB6-C05E-4475-81EF-9E126D6CA631#';
const openURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  late double rate;

  Future getCoinData(String selectedCurrency, String crypto) async {
    http.Response response = await http
        .get(Uri.parse('$openURL/$crypto/$selectedCurrency?apikey=$apiKey'));
    if (response.statusCode == 200) {
      var data = response.body;
      rate = jsonDecode(data)['rate'];
      var rateData = rate.toStringAsFixed(0);
      return rateData;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

      // throw 'Problem with the get request'; // TODO understan exception