import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants.dart';
import '../widgets/custom_key_pad.dart';
import '../widgets/custom_selection_item.dart';

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

  //CMC-Lista de los nombres de las currencies (dropdown menu)
  String? currencySelected1 = 'USD';
  String? currencySelected2 = 'COP';

  //Function to show pressed btn value
  void btnPressed(String btnVal) {
    if (btnVal != '<') {
      if (upperText.length > 10) {
        res = upperText;
      } else {
        res = upperText + btnVal;
      }
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

  void setCurrency1(String currencySelected) {
    currency1 = currencies.indexOf(currencySelected);
    setState(() {
      currencySelected1 = currencySelected;
      lowerText = convert(upperText);
    });
  }

  void setCurrency2(String currencySelected) {
    currency2 = currencies.indexOf(currencySelected);
    setState(() {
      currencySelected2 = currencySelected;
      lowerText = convert(upperText);
    });
  }

  String convert(String? value) {
    String result = '';

    if (RegExp(r'^[0-9]+([.][0-9]+)?$').hasMatch(value!)) {
      double valueConverted =
          (double.parse(value) * rates[currency1][currency2]);
      if (valueConverted.toString().length > 10) {
        result = valueConverted.toStringAsExponential(5);
      } else {
        result = valueConverted.toString();
      }
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
                  width: 100,
                  // selector para la primera moneda
                  child: CustomSelectionItem(
                    initValue: currencySelected1!,
                    items: currencies,
                    onChangeCallback: setCurrency1,
                  ),
                ),
                SizedBox(
                  width: 100,
                  // selector para la segunda moneda
                  child: CustomSelectionItem(
                    initValue: currencySelected2!,
                    items: currencies,
                    onChangeCallback: setCurrency2,
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
                          font: (width * 0.12).sp,
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
                            font: (width * 0.12).sp,
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
