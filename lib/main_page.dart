import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final List<String> entries = <String>['A', 'B', 'C', 'D'];
  // final List<int> colorCodes = <int>[600, 500, 100, 900];
  late List data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('lib/assets/beans.json'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                // Decode the JSON
                var newData = json.decode(snapshot.data.toString());
                if (snapshot.hasData && snapshot.data!.length > 0) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: newData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.amber,
                        child: Center(child: Text(newData[index]['name'])),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Error Error'),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
