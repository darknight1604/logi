import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/components/text_field_widget.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/text_style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const _ChatGroupWidget(),
                ],
              ),
            ),
          ],
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
                  style: TextStyleManager.largeText,
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

class _ChatGroupWidget extends StatelessWidget {
  const _ChatGroupWidget({Key? key}) : super(key: key);

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
            child: Container(),
          ),
          Row(
            children: [
              SizedBoxWidget.w10,
              Expanded(
                child: TextFieldWidget(
                  hintText: LocaleKeys.commonSaySomething.tr(),
                ),
              ),
              const SizedBox(
                width: 50,
                child: Icon(
                  Icons.send_outlined,
                ),
              ),
            ],
          ),
          SizedBoxWidget.h10,
        ],
      ),
    );
  }
}
