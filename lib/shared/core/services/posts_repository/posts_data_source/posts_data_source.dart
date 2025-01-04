import '../../../models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();

  Future<Post> updatePost(Post post);

  Future<Post> createPost(Post post);
}
