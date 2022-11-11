import 'package:flutter/material.dart';
import 'package:novo_curso/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];
    for (String currency in currenciesList) {
      Text(currency);
      cupertinoItems.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: ((selectedIndex) {
          print(selectedIndex);
          setState(() {
            selectedCurrency = currenciesList[selectedIndex];
            getData();
          });
        }),
        children: cupertinoItems);
  }

  List cryptoValue = ['?', '?', '?'];

  void getData() async {
    List cryptos = [];
    try {
      for (String crypto in cryptoList) {
        var data = await CoinData().getCoinData(selectedCurrency, crypto);
        cryptos.add(data);
        print(cryptos);
      }
      setState(() {
        cryptoValue[0] = cryptos[0];
        cryptoValue[1] = cryptos[1];
        cryptoValue[2] = cryptos[2];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < cryptoList.length; i++)
                CardCrypto(
                  cryptoValue: cryptoValue[i],
                  selectedCurrency: selectedCurrency,
                  crypto: cryptoList[i],
                ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CardCrypto extends StatelessWidget {
  const CardCrypto({
    Key? key,
    required this.cryptoValue,
    required this.selectedCurrency,
    required this.crypto,
  }) : super(key: key);

  final String cryptoValue;
  final String selectedCurrency;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $cryptoValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}



              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: (context, index) {
              //       return CardCrypto(
              //           cryptoValue: cryptoValue[index],
              //           selectedCurrency: selectedCurrency,
              //           crypto: cryptoList[index]);
              //     },
              //     itemCount: cryptoList.length,
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //   ),
              // )