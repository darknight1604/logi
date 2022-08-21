import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
import 'package:logi/core/components/circle_button_widget.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/components/text_field_widget.dart';
import 'package:logi/core/domains/models/message.dart';
import 'package:logi/core/domains/models/user.dart';
import 'package:logi/core/helpers/log.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/text_style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logi/screens/home_screen/applications/chat_message/chat_message_bloc.dart';
import 'package:logi/screens/home_screen/applications/chat_scroll_button/chat_scroll_button_cubit.dart';
import 'package:logi/screens/home_screen/repository/chat_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMessageBloc(
        chatRepository: RepositoryProvider.of<ChatRepository>(context),
        authorizationBloc: BlocProvider.of<AuthorizationBloc>(context),
      )..add(GetCountMessageEvent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const _UserCardWidget(),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          LocaleKeys.commonComingSoon.tr(),
                          style: TextStyleManager.extraLargeText.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    BlocProvider<ChatScrollButtonCubit>(
                      create: (_) => ChatScrollButtonCubit(),
                      child: const _ChatGroupWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCardWidget extends StatelessWidget {
  const _UserCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
          if (state is UserAuthorizedState && state.isAuthorized) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  state.user?.nickname ?? '',
                  style: TextStyleManager.largeText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onExit(context);
                  },
                  child: Text(
                    LocaleKeys.commonExit.tr(),
                    style: TextStyleManager.normalText.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }
          return Text(
            LocaleKeys.commonHomeScreen.tr(),
            style: TextStyleManager.largeText,
          );
        },
      ),
    );
  }

  void _onExit(final BuildContext context) {
    BlocProvider.of<AuthorizationBloc>(context).add(
      LogoutEvent(),
    );
    Navigator.popAndPushNamed(
      context,
      LogiRoute.welcomeScreen,
    );
  }
}

class _ChatGroupWidget extends StatefulWidget {
  const _ChatGroupWidget({Key? key}) : super(key: key);

  @override
  State<_ChatGroupWidget> createState() => _ChatGroupWidgetState();
}

class _ChatGroupWidgetState extends State<_ChatGroupWidget> {
  late TextEditingController controller;
  late FocusNode focusNode;
  late ScrollController scrollController;
  final itemKey = GlobalKey();

  final double maxHeightPerItemMessage = 20.0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    focusNode = FocusNode();
    scrollController = ScrollController();
    scrollController.addListener(() {
      double offset = scrollController.offset;
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double offsetShowButton = maxScrollExtent - (maxHeightPerItemMessage * 5);
      final chatScrollButtonCubit =
          BlocProvider.of<ChatScrollButtonCubit>(context);
      final currentState = chatScrollButtonCubit.state;
      if (offsetShowButton >= 0 &&
          offset <= offsetShowButton &&
          !currentState) {
        chatScrollButtonCubit.showButton();
        return;
      }
      if (offset > offsetShowButton &&
          offset <= maxScrollExtent &&
          currentState) {
        chatScrollButtonCubit.hideButton();
        return;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatMessageBloc, ChatMessageState>(
              listener: (context, state) {
                if (state is ChatMessageScrollToBottomState) {
                  _scrollDown();
                  return;
                }
              },
              buildWhen: (previous, current) =>
                  current is! ChatMessageScrollToBottomState,
              builder: (context, state) {
                if (state is! ChatMessageListingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  color: Colors.grey[200],
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView.separated(
                        padding: const EdgeInsets.all(10.0),
                        controller: scrollController,
                        itemCount: state.messages.length + 1,
                        separatorBuilder: (_, __) => SizedBoxWidget.h10,
                        itemBuilder: (context, index) {
                          if (index == state.messages.length) {
                            return SizedBoxWidget.h15;
                          }
                          return _ChatMessageItemWidget(
                            message: state.messages[index],
                          );
                        },
                      ),
                      BlocBuilder<ChatScrollButtonCubit, bool>(
                        builder: (context, state) {
                          if (state) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CircleButtonWidget(
                                onTap: () => _scrollDown(),
                                color: Colors.blue,
                                child: const Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              SizedBoxWidget.w10,
              Expanded(
                child: TextFieldWidget(
                  controller: controller,
                  focusNode: focusNode,
                  hintText: LocaleKeys.commonSaySomething.tr(),
                  onSubmitted: (value) => _onSubmitted(context),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _onSubmitted(context);
                },
                child: const SizedBox(
                  width: 50,
                  child: Icon(
                    Icons.send_outlined,
                  ),
                ),
              ),
            ],
          ),
          SizedBoxWidget.h10,
        ],
      ),
    );
  }

  void _scrollDown() {
    try {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Log.error('_scrollDown', e.toString());
    }
  }

  void _onSubmitted(context) {
    BlocProvider.of<ChatMessageBloc>(context).add(
      SendMessageEvent(controller.text),
    );
    controller.clear();
    focusNode.requestFocus();
  }

  String getUserName(final BuildContext context) {
    User? user = getCurrentUser(context);
    if (user == null) return '';
    return user.nickname ?? '';
  }

  User? getCurrentUser(final BuildContext context) {
    final currentState = BlocProvider.of<AuthorizationBloc>(context).state;
    if (currentState is UserAuthorizedState && currentState.isAuthorized) {
      return currentState.user;
    }
    return null;
  }
}

class _ChatMessageItemWidget extends StatelessWidget {
  final Message message;

  const _ChatMessageItemWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.senderName ?? '',
            style: TextStyleManager.normalText.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(':'),
          SizedBoxWidget.w10,
          Expanded(
            child: Text(
              message.content ?? '',
              style: TextStyleManager.normalText,
            ),
          ),
        ],
      ),
    );
  }
}
