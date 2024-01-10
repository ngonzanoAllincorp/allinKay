import 'package:flutter/material.dart';

class ListaSorteos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedItem = 'Selecciona una opción';
  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'];

  Future<void> _showSelectionDialog(BuildContext context) async {
    final selectedOption = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Selecciona una opción'),
          children: options.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, option);
              },
              child: Text(option),
            );
          }).toList(),
        );
      },
    );

    if (selectedOption != null) {
      setState(() {
        selectedItem = selectedOption;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Dialog en Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Opción seleccionada: $selectedItem',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showSelectionDialog(context);
              },
              child: Text('Abrir Diálogo de Selección'),
            ),
          ],
        ),
      ),
    );
  }
}
