import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'currency_model.dart';
import './hive_util.dart';

class CurrProvider extends ChangeNotifier with HiveUtil {
  String s = 'salom';
  late int pos;
  //late CurrencyModel model;
  late CurrencyModel topCur;
  late CurrencyModel bottomCur;

  List<CurrencyModel?> listCurrency = [];
  CurrencyModel? data;
  Future<bool?> loadData() async {
    data = CurrencyModel();

    Future<bool> loadLocalData() async {
      try {
        // var temp = await getBox<List<CurrencyModel?>>('currBox', key: 'list');
        // if (temp != null) {
        //   listCurrency=temp;
        // }
        listCurrency = (await getBox('currBox').then((value)  
        {
           for (int i = 0; i < listCurrency.length; i++) {
          if (listCurrency[i]!.ccy == 'USD') {
            topCur = listCurrency[i]!;
          }
          if (listCurrency[i]!.ccy == 'RUB') {
            bottomCur = listCurrency[i]!;
          }
        }
        }))!;
       

        notifyListeners();
        //var model = listCurrency[0];

        // if (model!.date ==
        //     "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}") {
        //   data = model;
        //   return true;
        // }
        return true;
      } catch (e) {
        return false;
      }
    }

    var isLoad = await loadLocalData();

    if (!isLoad) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          listCurrency.clear();
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              // ignore: use_build_context_synchronously

              topCur = model;
            } else if (model.ccy == 'RUB') {
              // ignore: use_build_context_synchronously

              bottomCur = model;
            }
            // ignore: use_build_context_synchronously

            listCurrency.add(model);
          }
          //await deleteBox('currBox');
          await saveBox('currBox', listCurrency);
          //await saveBox('currBox', topCur, key: 'topCurr');
          //await saveBox('currBox', bottomCur, key: 'bottomCurr');
          notifyListeners();
          return true;
        } else {
          //_showMessage('Unknown error');
        }
      } on SocketException {
        // _showMessage('Connection error');
        //_loadData();

      } catch (e) {
        //_showMessage(e.toString());
      }
    } else {}
    return true;
  }

  exchangeCur() {
    var a = topCur;
    topCur = bottomCur;
    bottomCur = a;
    notifyListeners();
  }

  setS(String value) {
    s = value;
    notifyListeners();
  }

  setTopCur(var cur) {
    topCur = cur;
    notifyListeners();
  }

  setBottomCur(var cur) {
    bottomCur = cur;
    notifyListeners();
  }

  setPos(int value) {
    pos = value;
    notifyListeners();
  }

  setCurrlist(List<CurrencyModel> list) {
    listCurrency = list;
    notifyListeners();
  }
}
