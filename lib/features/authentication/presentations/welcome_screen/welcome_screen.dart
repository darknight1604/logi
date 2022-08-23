import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/components/text_field_widget.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/text_style_manager.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/applications/user/user_bloc.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logi/features/authentication/repositories/user_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController controller;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    userBloc = UserBloc(
      RepositoryProvider.of<UserRepository>(context),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => userBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is! CreateUserSuccessState) return;
              BlocProvider.of<AuthorizationBloc>(context).add(
                UserAuthorizeEvent(
                  state.user,
                ),
              );
            },
          ),
          BlocListener<AuthorizationBloc, AuthorizationState>(
            listener: (context, state) {
              if (state is! UserAuthorizedState) return;
              Navigator.popAndPushNamed(context, LogiRoute.homeScreen);
            },
          ),
        ],
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    controller: controller,
                    hintText: LocaleKeys.commonNickName.tr(),
                    onSubmitted: (value) {
                      userBloc.add(CreateUserEvent(controller.text));
                    },
                  ),
                  SizedBoxWidget.h10,
                  ElevatedButton(
                    onPressed: () {
                      userBloc.add(CreateUserEvent(controller.text));
                    },
                    child: Text(
                      LocaleKeys.commonSubmit.tr(),
                      style: TextStyleManager.normalText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
