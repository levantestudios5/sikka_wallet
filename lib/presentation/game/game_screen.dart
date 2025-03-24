import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sikka_wallet/constants/app_theme.dart';
import 'package:sikka_wallet/constants/assets.dart';
import 'package:sikka_wallet/constants/dimens.dart';
import 'package:sikka_wallet/core/widgets/game_card.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/domain/entity/game/game.dart';
import 'package:sikka_wallet/presentation/post/store/post_store.dart';

class GamesScreen extends StatefulWidget {
  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final PostStore postStore = getIt<PostStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA455F8),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF6EDFE),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimens.cardRadius),
          ),
        ),
        child: Observer(builder: (context) {
          return (postStore.gameList?.posts?.length ?? 0) > 0
              ? SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGameGrid(),
                      _buildDetailWidget(),
                    ],
                  ),
              )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.gameIcon,
                          height: 250,
                          color: Colors.grey,
                        ),
                        Text(
                          "You got no games to play at the moment!",
                          style: AppThemeData.buttonTextStyle
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget _buildGameGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: postStore.gameList!.posts!.length,
        physics: ScrollPhysics(),
        // Replace with actual game count
        itemBuilder: (context, index) {
          return GameCard(
            imageUrl: postStore.gameList!.posts![index].gameIconUrl,
            title: postStore.gameList!.posts![index].name,
            description: postStore.gameList!.posts![index].description,
            onPlayNow: () {
              print("Play Now Clicked!");
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.game,
            height: 100,
          ),
          Text(
            'More games are right in the corner. Stay connected with\nSikkaX',
            textAlign: TextAlign.center,
            style: AppThemeData.buttonTextStyle
                .copyWith(color: Colors.black87, fontSize: 19),
          )
        ],
      ),
    );
  }
}
