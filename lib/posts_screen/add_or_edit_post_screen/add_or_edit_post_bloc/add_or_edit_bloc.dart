import 'package:bloc/bloc.dart';
import 'package:correction_flutter_tp_al/shared/core/services/posts_repository/posts_repository.dart';
import 'package:meta/meta.dart';

import '../../../shared/core/exceptions/app_exception.dart';
import '../../../shared/core/models/post.dart';

part 'add_or_edit_event.dart';
part 'add_or_edit_state.dart';

class AddOrEditBloc extends Bloc<AddOrEditEvent, AddOrEditState> {
  final PostsRepository _postsRepository;

  AddOrEditBloc({required PostsRepository postsRepository})
      : _postsRepository = postsRepository,
        super(const AddOrEditState()) {
    on<AddPost>(_onAddPost);
    on<EditPost>(_onEditPost);
  }

  void _onAddPost(AddPost event, Emitter<AddOrEditState> emit) async {
    emit(state.copyWith(status: AddOrdEditStatus.addingPost));
    try {
      final post = await _postsRepository.createPost(event.post);
      emit(state.copyWith(
        status: AddOrdEditStatus.successAddingPost,
        post: post,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddOrdEditStatus.errorAddingPost,
        exception: AppException.from(e),
      ));
    }
  }

  void _onEditPost(EditPost event, Emitter<AddOrEditState> emit) async {
    emit(state.copyWith(status: AddOrdEditStatus.editingPost));
    try {
      final post = await _postsRepository.updatePost(event.post);
      emit(state.copyWith(
        status: AddOrdEditStatus.successEditingPost,
        post: post,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddOrdEditStatus.errorEditingPost,
        exception: AppException.from(e),
      ));
    }
  }
}
