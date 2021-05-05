
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pockettouristguide/Widgets/Loading.dart';

class DisplayInfo extends StatefulWidget {
  final Url;
  DisplayInfo({this.Url});
  @override
  DisplayInfoState createState() => DisplayInfoState();
}

class DisplayInfoState extends State<DisplayInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Places").doc("${widget.Url}")
                .snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData){
                return LoadingView();
              }else{
                return SafeArea(
                  child: Column(

                    children: [Expanded(flex: 2, child:Image.network("${snapshot.data["Place_ImgURL"]}",fit: BoxFit.fitWidth),),
                      Expanded(flex: 1,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("${snapshot.data["Place_Title"]}",style: Theme.of(context).textTheme.headline2.copyWith(fontSize: 25,fontWeight: FontWeight.bold),)),
                      ),),
                      Expanded(flex:4,child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${snapshot.data["Place_Description"]}",style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16)),
                      ) )

                    ],
                  ),
                );
              }
            }));
  }
}
