import 'dart:async';

import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_data_source/posts_data_source.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/post.dart';

class PostsRepository {
  final PostsDataSource _postsDataSource;

  PostsRepository({
    required PostsDataSource postsDataSource,
  }) : _postsDataSource = postsDataSource;

  final BehaviorSubject<List<Post>> _postsStreamController =
      BehaviorSubject<List<Post>>.seeded([]);

  Stream<List<Post>> getPosts() async* {
    final posts = await _postsDataSource.getPosts();
    _postsStreamController.add(posts);
    yield* _postsStreamController.asBroadcastStream();
  }

  Future<Post> updatePost(Post post) async {
    final currentPosts = [..._postsStreamController.value];
    final updatedPost = await _postsDataSource.updatePost(post);
    final index =
        currentPosts.indexWhere((element) => element.id == updatedPost.id);
    currentPosts[index] = updatedPost;
    _postsStreamController.add(currentPosts);
    return updatedPost;
  }

  Future<Post> createPost(Post post) async {
    final currentPosts = [..._postsStreamController.value];
    final createdPost = await _postsDataSource.createPost(post);
    currentPosts.add(createdPost);
    _postsStreamController.add(currentPosts);
    return createdPost;
  }
}
