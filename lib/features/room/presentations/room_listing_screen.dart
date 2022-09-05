import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/components/padding_wrapper.dart';
import 'package:logi/core/components/sized_box_widget.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/helpers/style_manager.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/domains/models/user.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/room/applications/room/room_bloc.dart';
import 'package:logi/features/room/domains/models/room.dart';
import 'package:logi/features/room/domains/models/room_user.dart';
import 'package:logi/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RoomListingScreen extends StatefulWidget {
  final GameEnum gameEnum;
  const RoomListingScreen({
    Key? key,
    required this.gameEnum,
  }) : super(key: key);

  @override
  State<RoomListingScreen> createState() => _RoomListingScreenState();
}

class _RoomListingScreenState extends State<RoomListingScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoomBloc>(context).add(
      GetListRoomEvent(widget.gameEnum),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBoxWidget.h10,
                Text(
                  LocaleKeys.roomListingScreenTitle.tr(),
                  style: TextStyleManager.extraLargeText,
                ),
                SizedBoxWidget.h10,
                Expanded(
                  child: BlocBuilder<RoomBloc, RoomState>(
                    builder: (context, state) {
                      if (state is! ListRoomState) {
                        return Container();
                      }
                      return Container(
                        color: Colors.grey[100],
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 25,
                          ),
                          itemCount: state.listRoomData.length,
                          itemBuilder: (context, index) {
                            MapEntry<Room, List<RoomUser>> data =
                                state.listRoomData.entries.toList()[index];
                            Room room = data.key;
                            List<RoomUser> roomUsers = data.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _IconUserWidget(
                                  isActive: [1, 2].contains(roomUsers.length),
                                ),
                                GestureDetector(
                                  onDoubleTap: () {
                                    if (roomUsers.length >=
                                        (room.maxSize ?? 0)) {
                                      return;
                                    }
                                    _joinRoom(context, room);
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Text(room.name ?? ''),
                                            ),
                                          ),
                                          Icon(
                                            Icons.fast_forward_outlined,
                                            color:
                                                roomUsers.length == room.maxSize
                                                    ? Colors.grey[700]
                                                    : Colors.grey[200],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                _IconUserWidget(
                                  isActive: roomUsers.length == 2,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const PaddingWrapper(
            child: BottomActionGroupWidget(),
          ),
        ],
      ),
    );
  }

  void _joinRoom(final BuildContext buildContext, Room room) async {
    User? user = BlocProvider.of<AuthorizationBloc>(buildContext).getUser();
    if (user == null) return;
    BlocProvider.of<RoomBloc>(buildContext).add(
      JoinRoomEvent(
        room: room,
        user: user,
      ),
    );
    await Navigator.pushNamed(
      buildContext,
      LogiRoute.caroScreen,
      arguments: {
        'userId': user.id,
        'roomId': room.id,
        'nickname': user.nickname,
      },
    ).then(
      (value) {
        BlocProvider.of<RoomBloc>(buildContext).add(
          LeaveRoomEvent(
            room: room,
            user: user,
          ),
        );
      },
    );
  }
}

class BottomActionGroupWidget extends StatelessWidget {
  final Function()? onPop;
  const BottomActionGroupWidget({
    Key? key,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyleManager.common,
            onPressed: () {
              onPop?.call() ?? Navigator.pop(context);
            },
            child: Text(
              LocaleKeys.commonBack.tr(),
              style: TextStyleManager.normalText,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconUserWidget extends StatelessWidget {
  final bool isActive;
  const _IconUserWidget({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person_outlined,
      size: 50,
      color: isActive ? Colors.green : Colors.grey[300],
    );
  }
}
