import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/components/padding_wrapper.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/style_manager.dart';
import 'package:logi/features/caro/applications/caro/caro_bloc.dart';
import 'package:logi/features/caro/domains/models/caro_position.dart';
import 'package:logi/features/caro/infrastructures/repositories/caro_repository.dart';
import 'package:logi/features/room/presentations/room_listing_screen.dart';
import 'package:logi/features/room/repositories/room_repository.dart';
import 'package:logi/gen/locale_keys.g.dart';

class CaroScreen extends StatefulWidget {
  final String roomId;
  final String userId;
  final String nickname;

  const CaroScreen({
    Key? key,
    required this.roomId,
    required this.userId,
    required this.nickname,
  }) : super(key: key);

  @override
  State<CaroScreen> createState() => _CaroScreenState();
}

class _CaroScreenState extends State<CaroScreen> {
  late CaroBloc caroBloc;
  @override
  void initState() {
    super.initState();
    caroBloc = CaroBloc(
      RepositoryProvider.of<CaroRepository>(context),
      RepositoryProvider.of<RoomRepository>(context),
    );
    caroBloc.add(
      InitDefaultData(
        roomId: widget.roomId,
        userId: widget.userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaroBloc>(
      create: (_) => caroBloc,
      child: Scaffold(
        body: Column(
          children: [
            SizedBoxWidget.h10,
            Center(
              child: Text(
                LocaleKeys.caroScreenTitle.tr(),
                style: TextStyleManager.extraLargeText,
              ),
            ),
            SizedBoxWidget.h10,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocConsumer<CaroBloc, CaroState>(
                        listener: (context, state) {
                          if (state is BingoState) {
                            _showDialogWinner(context, state.winnerNickname);
                            return;
                          }
                        },
                        buildWhen: (previous, current) {
                          return current is! NotYourTurnState &&
                              current is! BingoState;
                        },
                        builder: (context, state) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 500,
                                height: 500,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.25),
                                ),
                                child: (state is! ListPositionState)
                                    ? Center(
                                        child: Text(
                                          LocaleKeys.commonComingSoon.tr(),
                                          style: TextStyleManager.normalText
                                              .copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      )
                                    : GridView.count(
                                        // Create a grid with 2 columns. If you change the scrollDirection to
                                        // horizontal, this produces 2 rows.
                                        crossAxisCount: CaroBloc.maxColumn,
                                        // Generate 100 widgets that display their index in the List.
                                        children: List.generate(
                                            CaroBloc.maxColumn *
                                                CaroBloc.maxRow, (index) {
                                          CaroPosition position =
                                              state.listPosition[index];
                                          return _CaroPositionItemWidget(
                                            position: position,
                                            userId: widget.userId,
                                            nickname: widget.nickname,
                                          );
                                        }),
                                      ),
                              ),
                              if (state is ListPositionState &&
                                  state.roomUsers.length < caroBloc.maxSize)
                                Container(
                                  height: 500,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.9),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.commonPleaseWaitAnotherPlayer
                                          .tr(),
                                      style:
                                          TextStyleManager.largeText.copyWith(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const _DescriptionWidget(),
                    ],
                  ),
                ],
              ),
            ),
            PaddingWrapper(
              child: BottomActionGroupWidget(
                onPop: () {
                  if (caroBloc.roomUsers.length == 1) {
                    caroBloc.add(
                      ClearPositionEvent(
                        roomId: widget.roomId,
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogWinner(
    final BuildContext buildContext,
    String winnerNickname,
  ) {
    showDialog(
      context: buildContext,
      builder: (context) => AlertDialog(
        elevation: 24.0,
        title: Text(
          LocaleKeys.commonCongratulation.tr(),
          style: TextStyleManager.largeText.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: LocaleKeys.caroScreenWinnerDescription.tr(),
                style: TextStyleManager.normalText.copyWith(
                  color: Colors.grey,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: winnerNickname,
                style: TextStyleManager.normalText.copyWith(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _quitGame.call(buildContext);
            },
            child: Text(
              LocaleKeys.commonQuitGame.tr(),
              style: TextStyleManager.normalText,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _newGame.call(buildContext);
            },
            child: Text(
              LocaleKeys.commonNewGame.tr(),
              style: TextStyleManager.normalText,
            ),
          ),
        ],
      ),
    );
  }

  void _newGame(final BuildContext buildContext) {
    caroBloc.add(
      ClearPositionEvent(
        roomId: widget.roomId,
      ),
    );
    Navigator.pop(buildContext);
  }

  void _quitGame(final BuildContext buildContext) {
    if (caroBloc.roomUsers.length == 1) {
      caroBloc.add(
        ClearPositionEvent(
          roomId: widget.roomId,
        ),
      );
    }
    Navigator.popUntil(
      buildContext,
      (route) => route.settings.name == LogiRoute.welcomeScreen,
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaroBloc, CaroState>(
      builder: (context, state) {
        final caroBloc = BlocProvider.of<CaroBloc>(context);
        return Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${LocaleKeys.caroScreenHost.tr()}: ',
                        style: TextStyleManager.largeText.copyWith(),
                      ),
                      SizedBoxWidget.w10,
                      Text(
                        caroBloc.roomUsers.isNotEmpty
                            ? caroBloc.roomUsers.first.nickName ?? ''
                            : '',
                        style: TextStyleManager.largeText.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.close_outlined,
                      color: Colors.blue,
                    ),
                    SizedBoxWidget.w10,
                    Text(
                      caroBloc.getHost()?.nickName ?? '',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.radio_button_unchecked_outlined,
                      color: Colors.red,
                    ),
                    SizedBoxWidget.w10,
                    Text(
                      caroBloc.getOpponent()?.nickName ?? '',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CaroPositionItemWidget extends StatelessWidget {
  final CaroPosition position;
  final String userId;
  final String nickname;

  const _CaroPositionItemWidget({
    Key? key,
    required this.position,
    required this.userId,
    required this.nickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final caroBloc = BlocProvider.of<CaroBloc>(context);

    return GestureDetector(
      onTap: () {
        if (position.isSelected) return;
        caroBloc.add(
          SelectPositionEvent(
            userId: userId,
            nickname: nickname,
            position: position,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.25),
        ),
        child: caroBloc.getHost()?.userId == position.userId
            ? const Icon(
                Icons.close_outlined,
                color: Colors.blue,
              )
            : position.isSelected
                ? const Icon(
                    Icons.radio_button_unchecked_outlined,
                    color: Colors.red,
                  )
                : Container(),
      ),
    );
  }
}
