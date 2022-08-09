

import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'currency_page.dart';

// import 'package:lesson1/lesson_page.dart';
// import 'package:lesson1/nft_ui/auction_page.dart';
// import 'package:lesson1/nft_ui/discover_page.dart';
// import 'package:lesson1/trackizer/subscript_info_page.dart';

class Routes {
  // static const subscriptInfoPage = '/subscriptInfoPage';
  // static const auctionPage = '/auctionPage';
  // static const discoverPage = '/discoverPage';
  // static const lessonPage = '/lessonPage';
  static const mainPage = '/';
  static const currencyPage = '/currencyPage';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        
        case mainPage:
          return MaterialPageRoute(builder: (context) => const  MainPage());
        case currencyPage:
          return MaterialPageRoute(builder: (context) =>  CurrencyPage());
        
        default:
          return MaterialPageRoute(builder: (context) => const MainPage());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const MainPage());
    }
  }
}
