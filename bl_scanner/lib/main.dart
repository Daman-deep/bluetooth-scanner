import 'package:bl_scanner/ble_scnr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();

  }

}
 class MyHomePageState extends State<MyHomePage>{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth'),
      ),
      body: GetBuilder<ble_scnr>
        ( init: ble_scnr(),
        builder: (ble_scnr controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResult,
                      builder: (context, snapshot){
                        if( snapshot.hasData){
                          return ListView.builder
                            (itemBuilder: (context,index){
                            final data = snapshot.data![index];

                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.device.id.id),
                                trailing: Text(data.rssi.toString()),
                              ),
                            );
                          }
                        );
                        }else return Center(
                          child: Text('No Device Found'),
                        );
                      },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(onPressed: () => controller.Scandevice, child: Text('Scan'))

                ],
            ),
          );

      },

      )
    );


  }

 }