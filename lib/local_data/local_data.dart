import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'models/user_model.dart';

class LocalData {
  LocalData._();
  static final LocalData db = LocalData._();
  //static UserModel user;

  static bool keepSession = true;

  Box<dynamic> userBox;

  static UserModel _userModel;

  static UserModel get user {
    if(LocalData.db.userBox == null || !Hive.isBoxOpen("user_data")) return null;
    if(_userModel == null) _userModel = UserModel.fromJson(LocalData.db.userBox.toMap());
    return _userModel;
  }
  static set setUser (UserModel model) {
    _userModel = model;
  }

  initDB() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    userBox = await Hive.openBox<dynamic>("user_data");
    print("===================== DB CREATED =====================");
    /*      id TEXT PRIMARY_KEY,
          name         TEXT,
          lastname     TEXT,
          cellphone    TEXT,
          preference   TEXT,
          client       INTEGER,
          photo        TEXT,
          payments     TEXT*/
  }

  Future<void> createUser(UserModel model) async {
    if(userBox == null || !await Hive.boxExists("user_data")  || !Hive.isBoxOpen("user_data")){
      userBox = await Hive.openBox<dynamic>("user_data");
      print("===================== USERBOX CREATED =====================");
    }
    LocalData.setUser = model;
    print("===================== USER SAVED =====================");
    return await userBox.putAll(model.toJson());

  }

  void updateUser(UserModel model) async {
    await userBox.putAll(model.toJson());
    LocalData.setUser = model;
  }

  void removeUser() async {
    LocalData.setUser = null;
    await userBox.clear();
    await userBox.close();
  }
}
