import '../import_file.dart';
import 'package:dio/dio.dart' as DIO;

abstract class ArticleController
{
  //const String url = 'http://coolme.me:8888';
  //const String url = 'http://192.168.1.100:8888';
  //const String url = 'localhost:3000';
  static const String url = 'http://192.168.1.100:3000';

  static Future<bool> send({Article article})
  async {
    DIO.RequestOptions option = DIO.RequestOptions();
//    option.responseType = DIO.ResponseType.json;
//    option.connectTimeout = 5000;
    option.baseUrl = url;
//    option.contentType = DIO.Headers.jsonContentType;
    option.method = 'POST';
    option.data = article;
    DIO.Dio dio = DIO.Dio();
    DIO.Response response;
    try{
      response = await dio.request("/article", options: option);
    }catch(e)
    {
      print("error");
      print(e);
      return false;
    }
    if (response.statusCode == 200)
    {
      //final Map<String, dynamic> data = jsonDecode(response.data);
      return true;
    }
    else
    {
      return false;
    }
  }
}