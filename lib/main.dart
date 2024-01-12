import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'src/page/pages.dart';
import 'src/provider/user.dart';
import 'src/utils/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/utils/my_colors.dart';
import 'validar/validar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); //para que no gire la pantalla
  initializeDateFormatting().then((_) {
    getItProvider();
    // debugRepaintRainbowEnabled = true; //no borrar
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
      ],
      child: MaterialApp(
        title: 'JL Comunidad',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('es'), Locale('en')],
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: 'validar', //validar
        routes: {
          'validar': (_) => const ValidarPage(),
          'login': (_) => const LoginPage(),
          'home': (_) => const HomePage(),
          'RegisterEmailPassPage': (_) => const RegisterEmailPassPage(),
          'EmailPassPage': (_) => const EmailPassPage(),
        },
        theme: ThemeData(
          useMaterial3: true,
          primaryColorDark: Colors.black,
          // fontFamily: ,
          // primaryColor: MyColors.colorPrimario1,

          // primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(elevation: 0),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: MyColors.cPri5,
            errorStyle: const TextStyle(height: 1, fontFamily: 'medium'),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
            labelStyle: TextStyle(fontFamily: 'medium'),
            hintStyle: TextStyle(
              fontFamily: 'medium',
              color: MyColors.cAzulLogin,
            ),
            suffixStyle: TextStyle(fontFamily: 'medium'),
            helperStyle: TextStyle(fontFamily: 'medium'),
            prefixStyle: TextStyle(fontFamily: 'medium'),
            counterStyle: TextStyle(fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(5)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
