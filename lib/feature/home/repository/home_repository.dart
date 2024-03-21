import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gestao_viajem/feature/home/model/post_model.dart';

class HomeRepository {
  final Dio client;
  HomeRepository({
    required this.client,
  });

  Future<List<PostModel>> getPosts() async {
    try {
      final response = await client.get("/posts");

      return (response.data as List<dynamic>)
          .map((e) => PostModel.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postPost() async {
    try {
      final response = await client.post(
        "/posts",
        data: jsonEncode({
          'title': 'foo',
          'body': 'bar',
          'userId': 1,
        }),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
