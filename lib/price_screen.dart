import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'getfromhttp.dart';


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    Uiupdate();
    super.initState();
  }
  @override
  var BTC=null;
  var ETH=null;
  var LTC=null;
  String current_Currency = 'USD';

  DropdownButton<String> andorid_DropdownButton() {
    List<DropdownMenuItem<String>> ItemList = [];

    for (String currency in currenciesList) {
      var dropdownitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      ItemList.add(dropdownitem);
    }

    return DropdownButton<String>(
      value: current_Currency,
      items: ItemList,
      onChanged: (value) {
        setState(
              () {
            current_Currency = value;
            Uiupdate();
          },
        );
      },
    );
  }

  CupertinoPicker ios_cupertino_Picker() {
    List<Text> textItems = [];
    for (String currencey in currenciesList) {
      var Item = Text(currencey);
      textItems.add(Item);
    }

    return CupertinoPicker(
      children: textItems,
      itemExtent: 32.0,
      onSelectedItemChanged: (value)
      {
        current_Currency= currenciesList[value];
        Uiupdate();

      },
    );
  }







  Uiupdate()async{
    setState(() {
      BTC='wait';
      ETH='wait';
      LTC='wait';
    });
    GetFromhttp getFromhttp =GetFromhttp(selected_currency: current_Currency);
    int btc=await getFromhttp.Datafromweb('BTC');
    int eth=await getFromhttp.Datafromweb('ETH');
    int ltc=await getFromhttp.Datafromweb('LTC');

      setState((){
        BTC=btc;
        ETH=eth;
        LTC=ltc;
    });

  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $BTC $current_Currency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $ETH $current_Currency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $LTC $current_Currency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),




          Expanded(
            flex: 1,
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? ios_cupertino_Picker()
                  : andorid_DropdownButton(),
            ),
          ),
        ],
      ),
    );
  }
}
