import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
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
      body: Center(
        child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
          builder: (context, state) {
            if (state is UserAuthorizedState && state.isAuthorized) {
              return Text(state.user?.nickname ?? '');
            }
            return Text(LocaleKeys.commonHomeScreen.tr());
          },
        ),
      ),
    );
  }
}
