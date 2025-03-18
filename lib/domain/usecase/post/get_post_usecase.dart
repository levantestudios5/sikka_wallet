
import 'package:sikka_wallet/core/domain/usecase/use_case.dart';
import 'package:sikka_wallet/domain/entity/news/news_feed.dart';
import 'package:sikka_wallet/domain/entity/post/post_list.dart';
import 'package:sikka_wallet/domain/repository/post/post_repository.dart';

class GetPostUseCase extends UseCase<SikkaXNewsList, void> {

  final PostRepository _postRepository;

  GetPostUseCase(this._postRepository);

  @override
  Future<SikkaXNewsList>  call({required params}) {
    return _postRepository.getPosts();
  }
}