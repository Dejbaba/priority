
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthUtils{

  static String? userId;


  static generateUserId(){
    var uuid = Uuid();
    String userId = uuid.v4();
    saveUserId(id: userId);
  }


  static saveUserId({required String id})async{
    var _pref = await SharedPreferences.getInstance();
    _pref.setString('userId', id);
    userId = id;
    print('user id saved into storage:::::$id>>>>');
  }

  static Future<bool> isUserExist()async{
    var _pref = await SharedPreferences.getInstance();
    final _userId = _pref.getString('userId');
    if(_userId == null)
      return false;
    return _userId.isNotEmpty;
  }


  static initUser()async{
    final _isUserExist = await isUserExist();
    if(!_isUserExist){
      generateUserId();
      return;
    }
    var _pref = await SharedPreferences.getInstance();
    userId = _pref.getString('userId');
    print('user id retrieved from storage:::::$userId>>>>');
  }
}