// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mobile_test/utils/app_exception.dart';

class NetworkUtil {
  static NetworkUtil instance = NetworkUtil.internal();
  late Dio _dio;

  NetworkUtil.internal() {
    _dio = Dio();
  }

  factory NetworkUtil() => instance;

  Future<dynamic> post(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, String>? param,
      encoding}) async {
    try {
      Response response = await _dio.post(
        path,
        queryParameters: param,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> put(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, String>? param,
      encoding}) async {
    try {
      Response response = await _dio.put(
        path,
        queryParameters: param,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> postGetHeader(String path,
      {Map<String, String>? body,
      Map<String, String>? headers,
      Map<String, String>? param,
      encoding}) async {
    try {
      Response response = await _dio.post(
        path,
        queryParameters: param,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponseWithHeader(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> posts(String path,
      {Map? body,
      Map<String, String>? headers,
      Map<String, String>? param,
      encoding}) async {
    try {
      Response response = await _dio.post(
        path,
        queryParameters: param,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> get(String path,
      {Map<String, String>? param,
      Map<String, String>? headers,
      encoding}) async {
    try {
      Response response = await _dio.get(
        path,
        queryParameters: param,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> getImage(String path,
      {Map<String, String>? param,
      Map<String, String>? headers,
      encoding}) async {
    try {
      Response response = await _dio.get(
        path,
        queryParameters: param,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponseImage(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> getWithHeader(String path,
      {Map<String, String>? param,
      Map<String, String>? headers,
      encoding}) async {
    try {
      Response response = await _dio.get(
        path,
        queryParameters: param,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponseWithHeader(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> multipartOneFile(String req, String path,
      {Uint8List? bytes,
      String? fileName,
      Map<String, String>? headers,
      Map<String, String>? param,
      Map<String, String>? body,
      encoding}) async {
    try {
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes!, filename: fileName ?? ''),
        ...?body,
      });

      Response response = await _dio.post(
        path,
        queryParameters: param,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  Future<dynamic> delete(String path,
      {Map<String, String>? headers,
      Map<String, String>? param,
      encoding}) async {
    try {
      Response response = await _dio.delete(
        path,
        queryParameters: param,
        options: Options(
          headers: headers,
        ),
      );
      return _returnResponse(response);
    } catch (e) {
      throw handleError(e);
    }
  }

  dynamic _returnResponseWithHeader(Response response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseJson = {
          ...response.headers.map,
          ...response.data,
        };
        return responseJson;
      case 400:
        throw BadRequestException(response.data['message']);
      case 401:
        throw RefreshTokenFailedException('Response 401');
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw FetchDataException('Error 500 : ${response.data['message']}');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponseImage(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data['message']);
      case 401:
        throw RefreshTokenFailedException('Response 401');
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw FetchDataException('Error 500 : ${response.data['message']}');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data['message']);
      case 401:
        throw RefreshTokenFailedException('Response 401');
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
        throw FetchDataException('Error 500 : ${response.data['message']}');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic handleError(dynamic error) {
    // ignore: deprecated_member_use
    if (error is DioError) {
      if (error.response != null) {
        return _returnResponse(error.response!);
      } else {
        throw FetchDataException('No Internet connection');
      }
    } else {
      throw error;
    }
  }
}
