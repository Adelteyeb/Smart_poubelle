import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import'TestNotification.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCZBosqGgMBXNMrpDHpbj86OMzh4vulaaQ",
        appId: "smart-garbage-da99b",
        messagingSenderId: "311066472975",
        projectId: "1:311066472975:android:8a9011daa76f61f25ce97a",
        databaseURL: "https://smart-garbage-da99b-default-rtdb.firebaseio.com"
    )

  );
// await FirebaseApii().getTocken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


   double gaugeValue=0; // Valeur par défaut


  @override
  Widget build(BuildContext context) {
    // print()

    _readDataFromFirebase();

    //print(_readDataFromFirebase());
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              child:
              SfRadialGauge(

                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: 150,
                        pointers: <GaugePointer>[
                          NeedlePointer(value: gaugeValue)
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 0,
                              endValue: 50,
                              color: Colors.green,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(startValue: 50,
                              endValue: 100,
                              color: Colors.orange,
                              startWidth: 10,
                              endWidth: 10),
                          GaugeRange(startValue: 100,
                              endValue: 150,
                              color: Colors.red,
                              startWidth: 10,
                              endWidth: 10)
                        ]
                    )
                  ]

              )
          )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _writeDataToFirebase() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('etat');
    // Utilisation de la méthode set pour écrire des données dans la base de données
    await ref.set({
      "etat": "13",

    });
  }

  Future<void> _readDataFromFirebase() async {
    double value = 0;
    DatabaseReference starCountRef =
    FirebaseDatabase.instance.ref('etat');
    await starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      //updateStarCount(data);
      print('***************************');
      final valeur = data.toString();
      print(valeur);
      print('***************************');
     double.parse(valeur.substring(7, 9));

      double value = double.parse(valeur.substring(7, 9));
      print('***************************');
      print(value);
      print('***************************');
      setState(() {
        gaugeValue = value;
      });

    });
    print('***************************');
    print(gaugeValue);
    print('***************************');


  }



}

