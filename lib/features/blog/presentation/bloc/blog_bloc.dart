import 'dart:io';

import 'package:blog_app/features/blog/domain/usercase/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
  }

  void _onBlogUpload(
    BlogUploadEvent event,
    Emitter<BlogState> emit,
  ) async {
    final result = await uploadBlog(
      UploadBlogParams(
        userId: event.userId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );
    result.fold(
      (l) {
        emit(BlogFailure(l.message));
      },
      (r) => emit(
        BlogSuccess(),
      ),
    );
  }
}
