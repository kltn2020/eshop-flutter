import 'package:meta/meta.dart';
import 'package:ecommerce_flutter/src/models/Post.dart';

@immutable
class PostsState {
  final bool isError;
  final bool isLoading;
  final List<Post> posts;

  PostsState({
    this.isError,
    this.isLoading,
    this.posts,
  });

  //factory constructor will be later used to fill the initial main state.
  factory PostsState.initial() => PostsState(
        isError: false,
        isLoading: false,
        posts: const [],
      );

  //copyWith method will be later used to get a copy of our PostsState to update this piece of the main state.
  PostsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<Post> posts,
  }) {
    return PostsState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
    );
  }
}
