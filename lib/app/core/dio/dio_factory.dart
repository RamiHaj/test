import 'package:dio/dio.dart';
import 'package:untitled2/app/core/constants/urls.dart';


class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: ConstUrls.baseUrl,
        receiveDataWhenStatusError: true,
      ),

    );
  }

  static Future<Response> getData(
      {
        required String url,
        String? token,
        String lang = 'en',
        Map<String,dynamic>? query,
      })async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang' : lang,
      'Authorization':token??''
    };
    return await dio.get(
      url ,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
        Map<String,dynamic>? data,
        Map<String,dynamic>? query,
      })
  async{
    dio.options.headers =
    {
      'Content-Type':'application/json',
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData(
      {required String url,
        Map<String,dynamic>? query,
        String lang = 'en',
        String? token,
        required Map<String,dynamic> data})
  async{
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??''
    };
    return await dio.put(
        url,
        data: data,
        queryParameters: query
    );
  }
}