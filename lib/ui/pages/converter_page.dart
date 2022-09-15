import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants.dart';
import '../widgets/custom_key_pad.dart';

// un widget con estado en el cual mantenemos los dos indices
// de las monedas que vamos a convertir
class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // el estado del widget
  int currency1 = 1;
  int currency2 = 0;
  String text = '';
  String upperText = '';
  String lowerText = '';
  String res = '';
  String convertionStr = '';

  // función para construir el selector de monedas
  /*  List<Widget> _buildItems() {
    return currencies
        .map((val) => SelectionItem(
              title: val,
            ))
        .toList();
  } */

  //CMC-Lista de los nombres de las currencies (dropdown menu)
  List<String> currencyList = ['COP', 'USD', 'EU'];
  String? currencySelected1 = 'USD';
  String? currencySelected2 = 'COP';

  //Function to show pressed btn value
  void btnPressed(String btnVal) {
    if (btnVal != '<') {
      res = upperText + btnVal;
    } else if (upperText.isNotEmpty) {
      res = upperText.substring(0, upperText.length - 1);
    }

    if (RegExp(r'^[.][0-9]+?$').hasMatch(res)) {
      res = '0$res';
    } else if (RegExp(r'^0+([0-9]{1}?)').hasMatch(res)) {
      res = res.substring(1);
    } else if (res.split('.').length > 2) {
      res = upperText;
    }

    setState(() {
      upperText = res;
      lowerText = convert(res);
    });
  }

  //Function to erase displays
  void eraseDisplays() {
    setState(() {
      upperText = '';
      lowerText = '';
    });
  }

  String convert(String? value) {
    String result = '';

    if (RegExp(r'^[0-9]+([.][0-9]+)?$').hasMatch(value!)) {
      double valueConverted =
          (double.parse(value) * rates[currency1][currency2]);
      result = valueConverted.toString();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // El siguiente widget en el arbol es el Scaffold
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.currency_exchange_rounded,
          color: Colors.white,
          size: 26,
        ),
        title: const Text(
          'Currency converter - Group #7',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100.w,
                  // selector para la primera moneda
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    value: currencySelected1,
                    dropdownColor: Colors.grey[800],
                    items: currencies.map((String currencies) {
                      return DropdownMenuItem(
                        value: currencies,
                        child: Text(
                          currencies,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      currency1 = currencies.indexOf(newValue!);
                      setState(() {
                        currencySelected1 = newValue;
                        lowerText = convert(upperText);
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  // selector para la segunda moneda
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    value: currencySelected2,
                    dropdownColor: Colors.grey[800],
                    items: currencies.map((String currencies) {
                      return DropdownMenuItem(
                        value: currencies,
                        child: Text(
                          currencies,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      currency2 = currencies.indexOf(newValue!);
                      setState(() {
                        currencySelected2 = newValue;
                        lowerText = convert(upperText);
                      });
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _InfoText(
                          text: currencySelected1!,
                          color: Colors.white,
                          font: 18.sp,
                        ),
                      ],
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      children: [
                        _InfoText(
                          text: upperText,
                          color: Colors.white,
                          font: 50.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _InfoText(
                          text: currencySelected2!,
                          color: Colors.white,
                          font: width * 0.044,
                        ),
                      ],
                    ),
                    SizedBox(width: 15.w),
                    Flexible(
                      // Agregado para el problema de desborde
                      fit: FlexFit
                          .loose, // Agregado para el problema de desborde
                      child: Column(
                        children: [
                          _InfoText(
                            text: lowerText,
                            color: Colors.white,
                            font: width * 0.12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomKeyPad(
              callback: btnPressed,
              callbackErase: eraseDisplays,
            ),
          ],
        ),
      ),
    );
  }
}

class _EraseButton extends StatelessWidget {
  final Function callback;
  final Function callbackErase;
  const _EraseButton({
    Key? key,
    required this.callback,
    required this.callbackErase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: ElevatedButton(
        onPressed: () => callback('<'),
        onLongPress: () => callbackErase(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size.fromRadius(35.r),
          primary: Colors.grey[500],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final String text;
  final Function callback;

  const _CircularButton({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: ElevatedButton(
        onPressed: () => callback(text),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size.fromRadius(35.r),
          primary: Colors.grey[800],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Helvetica', fontSize: 30.sp),
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String text;
  final Color color;
  final double font;

  const _InfoText({
    Key? key,
    required this.text,
    required this.color,
    required this.font,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: font,
          fontFamily: 'Helvetica',
        ),
        overflow:
            TextOverflow.ellipsis, // Agregado para el problema de desborde
        softWrap: false, // Agregado para el problema de desborde
      ),
    );
  }
}
