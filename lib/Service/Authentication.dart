import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

class Authentication extends ChangeNotifier{

  final _auth = FirebaseAuth.instance;
  final _firestoreservice = FirebaseFirestore.instance;
  bool _busy;
Authentication(){
  _busy= false;
}

  get getbusy =>_busy;

  set setbusy(bool busy){
    _busy=busy;
    notifyListeners();
  }


  SignInwithCredential(String email,String pass)async{
    setbusy=true;
    try{
      var authresult = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
        _firestoreservice.collection("users").doc(email).set({"Email":email});
      setbusy=false;
      return authresult.user!=null;
    }catch(e){
      return e.message;
    }
   
  }

  LoginWithCredential(String email , String pass)async{
    setbusy= true;
    try{
      var authresult = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      await Future.delayed(Duration(seconds: 2));
      setbusy=false;
      return authresult.user!=null;

    }catch(E){
      return E.message;
    }
  }

  ForgotPassword(String email)async{
    setbusy=true;
    try{
      var authresult = await _auth.sendPasswordResetEmail(email: email);
      await Future.delayed(Duration(seconds: 2));

      setbusy=false;
      return true;
    }catch(e){
      return e.message;
    }

  }

  signout()async{
    setbusy=true;
    try{

      await _auth.signOut();
      await Future.delayed(Duration(seconds: 2));
      setbusy=false;
      return true;
    }catch(e){
      return e.message;
    }

  }


}