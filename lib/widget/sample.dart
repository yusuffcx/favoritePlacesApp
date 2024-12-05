import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<StatefulWidget> createState() => new MyStatefulWidgetState();

  // note: updated as context.ancestorStateOfType is now deprecated
  static MyStatefulWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyStatefulWidgetState>();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  String _string = "Not set yet";

  set string(String value) => setState(() => _string = value);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Text(_string),
        new MyChildClass(StringCallback: (val) => setState(() => _string = val))
      ],
    );
  }
}

class MyChildClass extends StatelessWidget {
  const MyChildClass({super.key, required this.StringCallback});
  final void Function(String val) StringCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            StringCallback("String from method 1");
          },
          child: const Text("Method 1"),
        ),
        ElevatedButton(
          onPressed: () {
            MyStatefulWidget.of(context)!.string = "String from method 2";
          },
          child: const Text("Method 2"),
        )
      ],
    );
  }
}

void main() => runApp(
      new MaterialApp(
        builder: (context, child) => new SafeArea(
            child: new Material(color: Colors.white, child: child)),
        home: new MyStatefulWidget(),
      ),
    );
