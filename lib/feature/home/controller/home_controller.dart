import 'package:gestao_viajem/feature/home/repository/home_repository.dart';
import 'package:mobx/mobx.dart';

import 'package:gestao_viajem/core/helpers/base_state.dart';
import 'package:gestao_viajem/feature/home/model/post_model.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final BaseState<List<PostModel>> state = BaseState<List<PostModel>>();

  final HomeRepository repository;

  HomeControllerBase(this.repository);

  Future<void> getPosts() async {
    await state.execute(() => repository.getPosts());
  }

  Future<void> postPost() async {
    // await state.execute(() => repository.postPost());
    await repository.postPost();
  }
}
