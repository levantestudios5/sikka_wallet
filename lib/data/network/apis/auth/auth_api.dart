import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sikka_wallet/core/data/network/dio/dio_client.dart';
import 'package:sikka_wallet/data/network/constants/endpoints.dart';
import 'package:sikka_wallet/data/network/rest_client.dart';
import 'package:sikka_wallet/domain/entity/auth/register_request.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AuthApi(this._dioClient, this._restClient);

  /// register user method
  Future<String> registerUser(
      RegisterRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.register,
         data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["message"]; // Success message
      } else {
        throw Exception("Unexpected error occurred");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        return e.response?.data["message"] ?? "An unknown error occurred";
      }
      return "An error occurred while processing your request";
    } catch (e) {
      return "Something went wrong. Please try again later.";
    }
  }


  /// Returns list of post in response
  Future<PostList> getOtp() async {
    try {
      final res = await _dioClient.dio.post(Endpoints.getOTP);
      return PostList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//   Future<PostList> getPosts() async {
//     try {
//       final res = await _restClient.get(Endpoints.getPosts);
//       return PostList.fromJson(res.data);
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }
}
