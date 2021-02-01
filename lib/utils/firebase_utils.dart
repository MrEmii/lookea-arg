import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/local_data/models/user_model.dart';
import 'package:lookea/models/shop_model.dart';

class FirebaseUtils{

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<ShopModel> getShop(String id) async {
    DocumentSnapshot shopData = await firestore.collection("locals").doc(id).get();
    ShopModel model = ShopModel.fromJson(shopData.data());
    return Future.value(model);
  }

  static Future<List<ShopModel>> getShops() async {
    Stream<QuerySnapshot> stream = firestore.collection("/locals").snapshots();

    QuerySnapshot snapshot = await stream.first;
    List<ShopModel> models = snapshot.docs.map((e) => ShopModel.fromJson(e.data())).toList();

    print("=========== MODELS ================");
    print(models);

    return models;
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot userData = await firestore.collection("users").doc(id).get();
    UserModel model = UserModel.fromJson(userData.data());
    return Future.value(model);
  }

  static Future<void> updateAccount({UserModel model, Map<String, dynamic> add}) async{
    if(add != null && add.containsKey("mail")) {
      await auth.currentUser.updateEmail(add["mail"]);
      await auth.currentUser.sendEmailVerification();
    }
    await firestore.collection("users").doc(auth.currentUser.uid).update(model.toJson());
    LocalData.db.updateUser(model);
  }

  static Future<String> uploadFile({String path, String id, File image}) async {

    try{
      Reference ref = storage.ref('$path/$id');
      await ref.putFile(image);

      return await ref.getDownloadURL();
    } on FirebaseException catch (e){
      return e.message;
    }
  }

  static Future<void> deleteFile({String path}) async {

    try{

      Reference ref = storage.ref(path);
      await ref.delete();

    } on FirebaseException catch (e){
      return e.message;
    }
  }

  static Future<String> reAuth({String email, String password}) async{
    try{
      UserCredential credential = await FirebaseUtils.auth.currentUser.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password));
      return "";
    } on FirebaseAuthException catch (e) {
      print("========= ERROR =========");
      if (e.code == 'weak-password') {
        return 'La contraseña es muy corta';
      } else if (e.code == 'email-already-in-use') {
        return 'El correo ya está registrado.';
      }else if(e.code == "wrong-password"){
        return "Contraseña incorrecta";
      } else if(e.code == "user-mismatch"){
        return "El correo o contraseña no son correctos";
      }
    } catch (e) {
      print(e);
    }
    return "Server error";
  }

  static Future<String> changePassword({String password, String newPassword}) async {
    String authenticated = await reAuth(email: auth.currentUser.email, password: password);
    if(authenticated.isNotEmpty){
      return authenticated;
    }
    try{
      await auth.currentUser.updatePassword(newPassword);
      return "";
    } on FirebaseAuthException catch (e) {
      print("========= ERROR =========");
      if (e.code == 'weak-password') {
        return 'La contraseña es muy corta';
      } else if (e.code == 'requires-recent-login') {
        return 'La autenticación falló.';
      }
    } catch (e) {
      print(e);
    }
    return "Server error";
  }

  static Future<String> resetPassword({String email}) async{
    try{
      await FirebaseUtils.auth.sendPasswordResetEmail(email: email);
      return "";
    } on FirebaseAuthException catch (e) {
      print("========= ERROR =========");
      if (e.code == 'invalid-email') {
        return 'El correo no es correcto';
      } else if(e.code == "user-not-found"){
        return "El correo no existe";
      }
    } catch (e) {
      print(e);
    }
    return "Server error";
  }

  static void logout() async{
    await auth.signOut();
    LocalData.db.removeUser();
  }

}