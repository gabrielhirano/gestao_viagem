import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_viajem/core/config/dependency_injection.dart';
import 'package:gestao_viajem/core/helpers/app_state.dart';
import 'package:gestao_viajem/core/layout/components/app_text.dart';
import 'package:gestao_viajem/core/layout/foundation/app_shapes.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

import 'package:gestao_viajem/feature/home/controller/home_controller.dart';
import 'package:gestao_viajem/feature/home/model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController controller;

  @override
  void initState() {
    controller = getIt<HomeController>();
    controller.getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: const AppText(
          text: 'Onfly',
          textStyle: AppTextStyle.headerH4,
        ),
      ),
      body: Observer(builder: (_) {
        return switch (controller.state.getState) {
          AppState.none => const CircularProgressIndicator(),
          AppState.loading => const CircularProgressIndicator(),
          AppState.empty => const Center(child: Text('Nenhum dado encontrado')),
          AppState.success => _sucessState(controller.state.getData ?? []),
          AppState.error => const Center(child: Text('Tela de erro')),
        };
      }),
    );
  }

  Widget _sucessState(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) {
        final post = posts[index];
        return InkWell(
          onTap: controller.postPost,
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: AppShapes.decoration(
              color: Colors.redAccent,
            ),
            margin: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: AppText(
                  text: '${post.title}',
                  textStyle: AppTextStyle.paragraphMediumBold,
                  textColor: appColors.white),
            ),
          ),
        );
      },
    );
  }
}
