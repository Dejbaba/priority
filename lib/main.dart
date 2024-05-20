import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/services/firestore/parent_service.dart';
import 'package:priority_test/ui/pages/discover.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if(Platform.isAndroid){
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: '${dotenv.env['API_KEY']}',
          appId: '${dotenv.env['APP_ID']}',
          messagingSenderId: '${dotenv.env['MESSAGING_SENDER_ID']}',
          projectId: '${dotenv.env['PROJECT_ID']}',
        )
    );
  }else{
    await Firebase.initializeApp();
  }
  //used to seed product and review data into fireStore
  //run product data first...then review data
  //ParentService().seedReviewData();
  //ParentService().seedProductData();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.urbanistTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          //'/': (context) =>Container(), ///use this when seeding data to fireStore
          '/': (context) =>Discover(),
        },
      ),
      designSize: Size(390, 844),
    );
  }
}

