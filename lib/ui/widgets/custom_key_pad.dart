import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomKeyPad extends StatefulWidget {
  final Function callbackErase;
  final Function callback;

  const CustomKeyPad({
    Key? key,
    required this.callbackErase,
    required this.callback,
  }) : super(key: key);

  @override
  State<CustomKeyPad> createState() => _CustomKeyPadState();
}

class _CustomKeyPadState extends State<CustomKeyPad> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: FixedColumnWidth(105.w),
      // border: TableBorder.all(width: 1, color: Colors.white),
      children: [
        TableRow(
          children: [
            _CircularButton(
              text: '7',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '8',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '9',
              callback: widget.callback,
            )
          ],
        ),
        TableRow(
          children: [
            _CircularButton(
              text: '4',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '5',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '6',
              callback: widget.callback,
            )
          ],
        ),
        TableRow(
          children: [
            _CircularButton(
              text: '1',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '2',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '3',
              callback: widget.callback,
            )
          ],
        ),
        TableRow(
          children: [
            _CircularButton(
              text: '0',
              callback: widget.callback,
            ),
            _CircularButton(
              text: '.',
              callback: widget.callback,
            ),
            _EraseButton(
              callback: widget.callback,
              callbackErase: widget.callbackErase,
            )
          ],
        ),
      ],
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
