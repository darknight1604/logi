import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/components/text_field_widget.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/text_style_manager.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logi/screens/welcome_screen/applications/welcome/welcome_bloc.dart';
import 'package:logi/core/infastructures/repositories/user_repository.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController controller;
  late WelcomeBloc welcomeBloc;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    welcomeBloc = WelcomeBloc(
      RepositoryProvider.of<UserRepository>(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => welcomeBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<WelcomeBloc, WelcomeState>(
            listener: (context, state) {
              if (state is! WelcomeCreateUserSuccess) return;
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
                      welcomeBloc.add(CreateUserEvent(controller.text));
                    },
                  ),
                  SizedBoxWidget.h10,
                  ElevatedButton(
                    onPressed: () {
                      welcomeBloc.add(CreateUserEvent(controller.text));
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
