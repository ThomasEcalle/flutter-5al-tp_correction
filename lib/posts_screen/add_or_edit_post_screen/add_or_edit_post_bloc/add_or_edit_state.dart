part of 'add_or_edit_bloc.dart';

enum AddOrdEditStatus {
  initial,
  editingPost,
  addingPost,
  successAddingPost,
  successEditingPost,
  errorEditingPost,
  errorAddingPost,
}

class AddOrEditState {
  final AddOrdEditStatus status;
  final Post? post;
  final AppException? exception;

  const AddOrEditState({
    this.status = AddOrdEditStatus.initial,
    this.post,
    this.exception,
  });

  AddOrEditState copyWith({
    AddOrdEditStatus? status,
    Post? post,
    AppException? exception,
  }) {
    return AddOrEditState(
      status: status ?? this.status,
      post: post ?? this.post,
      exception: exception ?? this.exception,
    );
  }
}
