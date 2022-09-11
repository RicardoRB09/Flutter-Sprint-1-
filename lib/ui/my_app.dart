import 'package:flutter/material.dart';
import 'pages/converter_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // aquí agregamos el MaterialApp al árbol de widgets
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency converter',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Helvetica',
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.orange,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Helvetica',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      // TODO
      // ConverterPage es el widget que presenta la página de la aplicación
      home: ConverterPage(),
    );
  }
}
