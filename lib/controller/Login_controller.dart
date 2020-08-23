import '../import_file.dart';
import 'package:dio/dio.dart' as DIO;

abstract class LoginController
{
  //const String url = 'http://coolme.me:8888';
  //const String url = 'http://192.168.1.100:8888';
  //const String url = 'localhost:3000';
  static const String url = 'http://192.168.1.100:3000';

  static Future<Person> loginPerson({Map<String, dynamic> jsonObj})
  async {
    DIO.RequestOptions option = DIO.RequestOptions();
//    option.responseType = DIO.ResponseType.json;
//    option.connectTimeout = 5000;
    option.baseUrl = url;
//    option.contentType = DIO.Headers.jsonContentType;
    option.method = 'POST';
    option.data = jsonObj;
    DIO.Dio dio = DIO.Dio();
    DIO.Response response;
    response = await dio.request("/login", options: option);
    final Map<String, dynamic> data = response.data;
    bool isLogin = data['isLogin'] as bool;
    Person person;
    if(!isLogin)
      {
        person = Person(isLogin: isLogin);
        return person;
      }
    person = Person.fromJson(data);
    return person;
  }
}
