import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List bgImages = [
    'https://images.unsplash.com/photo-1501630834273-4b5604d2ee31?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1489549132488-d00b7eee80f1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'
  ];
  Map data = {};

  //set background
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDaytime'] ? bgImages[0] : bgImages[1];
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    Color fontColor = data['isDaytime'] ? Colors.grey[800] : Colors.grey[200];
    print("The time is: $data");
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(bgImage), fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 120, 0.0, 0.0),
              child: Column(
                children: [
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDaytime': result['isDaytime']
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: fontColor,
                    ),
                    label: Text(
                      "Edit Location",
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: fontColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: TextStyle(fontSize: 66.0, color: fontColor),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
