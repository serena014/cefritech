import 'package:flutter/material.dart';

import 'SelectableBtn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Serena La débutante', selected: false,),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title, required this.selected});
  final String title;
  bool selected;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  late TextEditingController nameCtl;
  late TextEditingController dateCtl;
  late final MaterialStatesController statesController;

  @override
  void initState() {
    super.initState();
    nameCtl = TextEditingController();
    dateCtl = TextEditingController();
    statesController = MaterialStatesController(
        <MaterialState>{if (widget.selected) MaterialState.selected});
  }

  @override
  void dispose(){
    super.dispose();
    nameCtl.dispose();
    dateCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          formTextField(nameCtl, "Nom", TextInputType.text),
          space(1),
          formTextField(dateCtl, "Date", TextInputType.datetime),
          space(2),
          SelectableButton(
          selected: this.selected,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return null; // defer to the defaults
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.indigo;
                }
                return null; // defer to the defaults
              },
            ),
          ),
          onPressed: () {
            setState(() {
              selected = !selected;
            });
          },
          child: const Text('Cliquez ici'),
        ),
          ],
        ),
      ),
    );
  }
}

Widget formTextField(TextEditingController ctl, String lbT , TextInputType inputType)=>(
  TextFormField(
    controller: ctl,
    keyboardType: inputType,
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.person,
        color: Colors.pinkAccent,
      ),
      labelStyle: TextStyle(color: Colors.black),
      labelText: lbT
    ),
  )
);

Widget space(double height)=>(
  Container(height:height )

);