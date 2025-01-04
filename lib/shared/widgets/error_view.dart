import 'package:correction_flutter_tp_al/shared/core/exceptions/app_exception.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final AppException? error;

  const ErrorView({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final error = this.error ?? const UnknownException();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          error.message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
