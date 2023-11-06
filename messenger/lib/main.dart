import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/shop_app/cubit/cubit.dart';
import 'package:messenger/layout/social_app/cubit/cubit.dart';
import 'package:messenger/layout/social_app/social_layout.dart';
import 'package:messenger/modules/social_app/social_login/social_login_screen.dart';
import 'package:messenger/shard/bloc_observer.dart';
import 'package:messenger/shard/components/components.dart';
import 'package:messenger/shard/components/constants.dart';
import 'package:messenger/shard/cubit/cubit.dart';
import 'package:messenger/shard/cubit/states.dart';
import 'package:messenger/shard/network/local/cache_helper.dart';
import 'package:messenger/shard/network/rmote/dio_helper.dart';
import 'package:messenger/shard/styles/themes.dart';

import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.data}");
    showToast(
        text: "Handling a background message", state: ToastStates.SUCCESS);
  }

  var token = await FirebaseMessaging.instance.getToken();
  print("tokenFirebase " + token.toString());
  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print("resvNotification:");
    print(event.data.toString());
    showToast(text: "onMessage", state: ToastStates.SUCCESS);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("resvOpenedAppNotification:");
    print(event.data.toString());
    showToast(text: "onMessageOpenedApp", state: ToastStates.SUCCESS);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  BlocOverrides.runZoned(
    () async {
      // Use blocs...
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getData(key: 'isDark');
      Widget widget;
      // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      // token = CacheHelper.getData(key: 'token');
      // if (onBoarding != null) {
      //   if (token != null)
      //     widget = ShopLayout();
      //   else
      //     widget = ShopLoginScreen();
      // } else
      //   widget = OnBoardingScreen();
      uId = CacheHelper.getData(key: 'uId');
      if (uId != null) {
        widget = SocialLayout();
      } else {
        widget = SocialLoginScreen();
      }
      runApp(MyApp(isDark, widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
  MyApp(
    this.isDark,
    this.startWidget,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (context) {
            return NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience();
          },
        ),
        BlocProvider<Appcubit>(
          create: (context) => Appcubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider<SocailCubit>(
          create: (context) => SocailCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<Appcubit, AppSates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: darkTheme,
            themeMode:
                Appcubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.ltr, child: startWidget),
          );
        },
      ),
    );
  }
}
