import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/local_data/models/user_model.dart';
import 'package:lookea/utils/firebase_utils.dart';

class SignInProvider extends ChangeNotifier{

  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      await fetchUser(userCredential.user.uid);
      if(userCredential.user.emailVerified){
        return "";
      }else{
        return "code";
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        return 'El correo no existente.';
      } else if (e.code == 'wrong-password') {
        return 'La contraseña que ingresate no es válida.';
      }
    } catch (e) {
      print(e);
    }

    return "Error de servidor";
  }

  Future<bool> authenticate() async{
    if(FirebaseUtils.auth.currentUser != null){
      FirebaseUtils.auth.currentUser.getIdToken().then((value) => print("TOKEN: $value"));
      await fetchUser(FirebaseUtils.auth.currentUser.uid);
      return true;
    }else{
      return false;
    }
  }

  Future<void> fetchUser(uid) async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    UserModel model = UserModel.fromJson(doc.data());
    await LocalData.db.createUser(model);
  }

  void reset(){
    passwordController = TextEditingController(text: "");
    emailController = TextEditingController(text: "");
  }

  void notify(){
      notifyListeners();
  }
}