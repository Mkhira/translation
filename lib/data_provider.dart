



import 'package:dio/dio.dart';

class DataProvider{
 static Future<Response> get() {
Dio dio = Dio();
return dio.get("http://192.168.45.94:41256/enterprise/Customers",
        options: Options(
          headers: {
            'Authorization':  'Basic 81CFDC6D61206789B3A5A349A13DE79D',
          },

        ));
  }
}