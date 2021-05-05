import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pockettouristguide/Scanner/Scanner.dart';
import 'package:pockettouristguide/Service/Authentication.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: FaIcon(FontAwesomeIcons.doorClosed),
              onPressed: () async {
                var result = await Authentication().signout();
                if (result is bool) {
                  if (!result) {
                    return showDialog(
                        context: _scaffold.currentContext,
                        builder: (context) => AlertDialog(
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "There is an ERROR",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                            color: Colors.teal, fontSize: 20),
                                  ),
                                  Text(
                                    "${result}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            color: Colors.teal, fontSize: 15),
                                  )
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  }
                }
              })
        ],
        title: Text("Pocket Tourist Guide"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "Application Decription will be here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 18),
                )),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFF1edcb0))),
              // color: Color(0xFFF1edcb0),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Scanner()));
              },
              child: Text(
                "Tap to Scan",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc("${FirebaseAuth.instance.currentUser.email}")
                    .snapshots(),
                builder: (builder, snapshot) => ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        title: snapshot.data["Recent Searches"][index],
                      ),
                      itemCount: snapshot.data["Recent Searches"].length,
                    )),
          ],
        ),
      ),
    );
  }
}
