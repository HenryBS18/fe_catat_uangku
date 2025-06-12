import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/services/user_service.dart';
import 'package:fe_catat_uangku/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserProfileBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserProfileBloc({required this.userService}) : super(UserInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(UserProfileLoading());

      try {
        final user = await userService.getUserProfile();
        emit(UserProfileLoaded(user));
      } catch (e) {
        emit(UserProfileError(e.toString()));
      }
    });
  }
}
