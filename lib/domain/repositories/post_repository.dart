import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts({
    int page = 1,
    int limit = 20,
    String? search,
    List<String>? tags,
  });
  Future<PostEntity> getPostById(String id);
  Future<PostEntity> createPost({
    required String title,
    required String content,
    List<String>? tags,
    List<String>? images,
  });
  Future<PostEntity> updatePost({
    required String id,
    String? title,
    String? content,
    List<String>? tags,
    List<String>? images,
  });
  Future<void> deletePost(String id);
  Future<PostEntity> likePost(String id);
  Future<PostEntity> unlikePost(String id);
  Future<List<PostEntity>> getUserPosts({
    required String userId,
    int page = 1,
    int limit = 20,
  });
  Future<List<PostEntity>> getLikedPosts({
    int page = 1,
    int limit = 20,
  });
}