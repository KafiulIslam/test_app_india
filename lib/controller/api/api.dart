import 'package:dio/dio.dart';
import 'dio.dart';

Future<Map<String, dynamic>> getCountryList() async {
  try {
    var response = await dio.get('getCountries');
    return {'status': 'success', 'data': response.data};
  } on DioError catch (e) {
    return getErrorResponse(e);
  }
}