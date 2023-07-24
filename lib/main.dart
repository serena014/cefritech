import 'package:flutter/material.dart';
import 'package:presentations/functions/home_data.dart';

import 'selectable_btn.dart';

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
      home: const MyHomePage(title: 'Serena La débutante', selected: false,),
    );
  }
}

class MyHomePage extends StatefulWidget {
   const MyHomePage({super.key, required this.title, required this.selected});
  final String title;
  final bool selected;

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  late TextEditingController nameCtl;
  late TextEditingController dateCtl;
  late final MaterialStatesController statesController;
  // ignore: prefer_typing_uninitialized_variables
  late var datas;
  StudentData stD = StudentData();

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
          selected: selected,
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
          onPressed: () async {
            datas = <String , dynamic> {
              'name': nameCtl.text,
              'date': dateCtl.text
            };
            await stD.saveJsonData(datas);
          },
          child: const Text('Enregistrer'),
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
      prefixIcon: const Icon(
        Icons.person,
        color: Colors.pinkAccent,
      ),
      labelStyle: const TextStyle(color: Colors.black),
      labelText: lbT
    ),
  )
);

Widget space(double height)=>(
  Container(height:height )

);