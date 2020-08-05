import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      // ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepPurple,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(65.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/NEDU.jpeg'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Chinedu',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Colors.white),
                  ),
                  Text(
                    'unfortunate i was born a nigerian',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Text(
                      'Share Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(1.1, -1.1),
              child: Container(
                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white30,
                ),
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 300.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    if (index == 1) {
                      return buildCard('photo', Icons.photo);
                    }
                    if (index == 2) {
                      return buildCard("Call me", Icons.call);
                    }
                    if (index == 4) {
                      return buildCard("email", Icons.email);
                    }

                    return buildCard("Contact", Icons.contact_phone);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, IconData icon) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(4.0),
        color: Colors.white,
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            print("clicked");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
              ),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
