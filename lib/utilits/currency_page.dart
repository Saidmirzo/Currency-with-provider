import 'package:currency/utilits/currency_model.dart';
import 'package:currency/utilits/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'const.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final List<CurrencyModel?> _filterList = [];
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _filterList.addAll(context.read<CurrProvider>().listCurrency);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff1f2235),
          automaticallyImplyLeading: false,
          title: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              fillColor: const Color(0xff2d334d),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
                size: 20,
              ),
              hintText: 'Search',
              hintStyle: sTextStyle(
                  color: Colors.white54, size: 16, fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.clear, color: Colors.white, size: 20),
              ),
            ),
            style: sTextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _filterList.clear();
                for (final item in context.read<CurrProvider>().listCurrency) {
                  if (item!.ccy!.toLowerCase().contains(value.toLowerCase()) ||
                      item.ccyNmEn!
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                    _filterList.add(item);
                  }
                }
              } else {
                _filterList.addAll(context.read<CurrProvider>().listCurrency);
              }
              setState(() {});
            },
          ),
        ),
        backgroundColor: const Color(0xff1f2235),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            shrinkWrap: true,
            itemBuilder: ((context, index) {
              var model = _filterList[index];
              bool isChosen =
                  context.watch<CurrProvider>().topCur == model ||
                      context.watch<CurrProvider>().bottomCur == model;
              return ListTile(
                onTap: () {
                  if (isChosen) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'It has been chossen',
                          style: sTextStyle(),
                        ),
                      ),
                    );
                  } else {
                   
                    if (context.read<CurrProvider>().pos == 1) {
                      provider.setTopCur(model);
                    } else {
                      provider.setBottomCur(model);
                    }
                    provider.setS('Hello Saidmirzo');
                    Navigator.pop(context);
                  }
                },
                tileColor: const Color(0xff2d334d),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SvgPicture.asset(
                    'assets/flags/${model!.ccy?.substring(0, 2).toLowerCase()}.svg',
                    height: 45,
                    width: 45,
                  ),
                ),
                title: Text(
                  model.ccy.toString(),
                  style: sTextStyle(
                      color: Colors.white,
                      size: 22,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  model.ccyNmEn.toString(),
                  style: sTextStyle(
                      color: Colors.white54,
                      size: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  model.rate ?? '',
                  style: sTextStyle(size: 22, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: isChosen
                        ? const BorderSide(color: Color(0xff10a4d4), width: 2)
                        : BorderSide.none),
              );
            }),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: _filterList.length),
      );
    });
  }
}
