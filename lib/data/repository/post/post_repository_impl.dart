import 'dart:async';
import 'package:sikka_wallet/data/network/apis/posts/post_api.dart';
import 'package:sikka_wallet/domain/entity/post/post.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  // data source object

  // api objects
  final PostApi _postApi;

  // constructor
  PostRepositoryImpl(this._postApi);

  // Post: ---------------------------------------------------------------------
  @override
  Future<PostList> getPosts() async {
    return await _postApi.getPosts().then((postsList) {
      postsList.posts?.forEach((Post post) {
      });

      return postsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(Post post) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> findPostById(int id) {
    // TODO: implement findPostById
    throw UnimplementedError();
  }

  @override
  Future<int> insert(Post post) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<int> update(Post post) {
    // TODO: implement update
    throw UnimplementedError();
  }

 }
