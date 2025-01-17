import 'dart:convert';
import 'dart:developer';
import 'package:constructor/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import './storage_service.dart';

enum Result { success, error }

class HttpService {
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? param,
  }) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
    };

    Uri url = Uri.http(ApiConsts.baseUrl, endpoint, param);
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [GET]: ${response.body}\nCode: ${response.statusCode}\nURL: $url");
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool isAuth = false,
  }) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
    };

    Uri url = Uri.http(ApiConsts.baseUrl, endpoint);
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [POST]: ${response.body}");

        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
    };

    Uri url = Uri.http(ApiConsts.baseUrl, endpoint);
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [PUT]: ${response.body}");
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
    };

    Uri url = Uri.http(ApiConsts.baseUrl, endpoint);
    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [PATCH]: ${response.body}");

        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    String token = StorageService.read("token") ?? "";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
    };

    Uri url = Uri.http(ApiConsts.baseUrl, endpoint);
    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'data': jsonDecode(response.body),
          'status': Result.success,
        };
      } else {
        log("Error [DELETE]: ${response.body}");
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log("Error: $e");
      return {
        'status': Result.error,
      };
    }
  }

  static Future<Map<String, dynamic>> uploadWithImages(
    String endpoint, {
    required Map<String, dynamic> body,
    String method = 'post',
  }) async {
    final String token = StorageService.read("token");
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        if (token.isNotEmpty) ...{"Authorization": "Bearer $token"},
      };

      // API endpoint
      final url = Uri.http(
        ApiConsts.baseUrl,
        endpoint,
        {'_method': method},
      );

      var request = http.MultipartRequest("post", url);

      request.headers.addAll(headers);

      if (body['images'] != null) {
        for (var imagePath in body['images']) {
          request.files.add(await http.MultipartFile.fromPath(
            'images[]',
            imagePath,
            filename: imagePath.split('/').last,
          ));
        }
      }

      body.remove('images');

      request.fields.addAll({
        "data": jsonEncode(body),
      });

      var res = await request.send();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return {
          'data': jsonDecode(await res.stream.bytesToString()),
          'status': Result.success,
        };
      } else {
        log(await res.stream.bytesToString());
        return {
          'status': Result.error,
        };
      }
    } catch (e) {
      log('Error: $e');
      return {
        'status': Result.error,
      };
    }
  }
}
