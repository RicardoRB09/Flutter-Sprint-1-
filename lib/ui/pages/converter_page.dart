import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../widgets/selection_item.dart';

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
  List<Widget> _buildItems() {
    return currencies
        .map((val) => SelectionItem(
              title: val,
            ))
        .toList();
  }

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

    convertionStr = '';

    if (RegExp(r'^[0-9]+([.][0-9]+)?$').hasMatch(res)) {
      double valueConverted = (double.parse(res) * rates[currency1][currency2]);
      convertionStr = valueConverted.toStringAsFixed(2);
    }

    setState(() {
      upperText = res;
      lowerText = convertionStr;
    });
  }

  //Function to erase displays
  void eraseDisplays() {
    setState(() {
      upperText = '';
      lowerText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // El siguiente widget en el arbol es el Scaffold
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Currency converter - Group #7',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  // selector para la primera moneda
                  child: DirectSelect(
                      itemExtent: 45.0,
                      selectedIndex: currency1,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onSelectedItemChanged: (index) {
                        // aquí cambiamos el estado del widget
                        setState(() {
                          currency1 = index ?? 0;
                        });
                      },
                      items: _buildItems(),
                      child: SelectionItem(
                        isForList: false,
                        title: currencies[currency1],
                      )),
                ),
                Expanded(
                  // selector para la segunda moneda
                  child: DirectSelect(
                      itemExtent: 45.0,
                      selectedIndex: currency2,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onSelectedItemChanged: (index) {
                        // aquí cambiamos el estado del widget
                        setState(() {
                          currency2 = index ?? 0;
                        });
                      },
                      items: _buildItems(),
                      child: SelectionItem(
                        isForList: false,
                        title: currencies[currency2],
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _InfoText(
                            text: currencies[currency1],
                            color: Colors.white,
                            font: 18,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          _InfoText(
                            text: upperText,
                            color: Colors.white,
                            font: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _InfoText(
                            text: currencies[currency2],
                            color: Colors.white,
                            font: 18,
                          ),
                        ],
                      ),
                      Flexible(
                        // Agregado para el problema de desborde
                        fit: FlexFit
                            .loose, // Agregado para el problema de desborde
                        child: Column(
                          children: [
                            _InfoText(
                              text: lowerText,
                              color: Colors.white,
                              font: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Table(
                    defaultColumnWidth: FixedColumnWidth(110),
                    // border: TableBorder.all(width: 1, color: Colors.white),
                    children: [
                      TableRow(
                        children: [
                          _CircularButton(
                            text: '7',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '8',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '9',
                            callback: btnPressed,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          _CircularButton(
                            text: '4',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '5',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '6',
                            callback: btnPressed,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          _CircularButton(
                            text: '1',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '2',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '3',
                            callback: btnPressed,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          _CircularButton(
                            text: '0',
                            callback: btnPressed,
                          ),
                          _CircularButton(
                            text: '.',
                            callback: btnPressed,
                          ),
                          _EraseButton(
                            callback: btnPressed,
                            callbackErase: eraseDisplays,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ));
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
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: () => callback('<'),
        onLongPress: () => callbackErase(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size.fromRadius(35),
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
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: () => callback(text),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: const Size.fromRadius(35),
          primary: Colors.grey[800],
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Helvetica', fontSize: 30),
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
