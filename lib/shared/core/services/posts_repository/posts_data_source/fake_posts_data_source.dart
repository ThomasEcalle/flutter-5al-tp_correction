import 'package:correction_flutter_tp_al/shared/core/exceptions/app_exception.dart';
import 'package:correction_flutter_tp_al/shared/core/models/post.dart';
import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_data_source/posts_data_source.dart';

class FakePostsDataSource extends PostsDataSource {
  final List<Post> _fakePosts = [];

  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> updatePost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((element) => element.id == post.id);
    if (index == -1) throw const PostNotFoundException();
    _fakePosts[index] = post;
    return post;
  }

  @override
  Future<Post> createPost(Post post) async {
    await Future.delayed(const Duration(seconds: 1));
    final createdPost = post.copyWith(id: DateTime.now().toString());
    _fakePosts.add(createdPost);
    return createdPost;
  }
}
