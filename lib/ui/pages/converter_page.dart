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

  // función para construir el selector de monedas
  List<Widget> _buildItems() {
    return currencies
        .map((val) => SelectionItem(
              title: val,
            ))
        .toList();
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
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          _InfoText(text: 'USD', color: Colors.white, font: 18),
                        ],
                      ),
                      Column(
                        children: const [
                          _InfoText(
                              text: '0.00', color: Colors.white, font: 50),
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
                        children: const [
                          _InfoText(text: 'COP', color: Colors.white, font: 18),
                        ],
                      ),
                      Column(
                        children: const [
                          _InfoText(
                              text: '0.00', color: Colors.white, font: 50),
                        ],
                      ),
                    ],
                  ),
                  Table(ç),
                ],
              ),
            )
          ]),
        ));
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
      ),
    );
  }
}
