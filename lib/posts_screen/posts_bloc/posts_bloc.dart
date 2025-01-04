import 'package:bloc/bloc.dart';
import 'package:correction_flutter_tp_al/shared/core/exceptions/app_exception.dart';
import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_repository.dart';
import 'package:meta/meta.dart';

import '../../shared/core/models/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc({required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(const PostsState()) {
    on<GetPosts>(_onGetPosts);
  }

  void _onGetPosts(GetPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));

    /// If the repository was to return a Future, we would use the following code:
    // try {
    //   final posts = await _postsRepository.getPosts();
    //   emit(state.copyWith(status: PostsStatus.success, posts: posts));
    // } catch (error) {
    //   emit(state.copyWith(status: PostsStatus.error, exception: AppException.from(error)));
    // }

    /// But because the repository returns a Stream, we use the following code:
    await emit.forEach(
      _postsRepository.getPosts(),
      onData: (posts) => state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ),
      onError: (error, _) => state.copyWith(
        status: PostsStatus.error,
        exception: AppException.from(error),
      ),
    );
  }
}
