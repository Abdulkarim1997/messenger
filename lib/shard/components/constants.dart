//  POST
// UPDATE
// DELETE
// GET

// Base url: https://newsapi.org/
// method (url): v2/everything?
// queries: q=tesla&from=2022-05-28&sortBy=publishedAt&apiKey=6a9066e9164e4437a9389c06b869642a

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) navigateAndFinish(context, ShopLoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

String? token = '';
String? uId = '';
