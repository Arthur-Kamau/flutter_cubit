import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/models/user_details.dart';
import 'package:flutter_cubit/state/home_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit(UserDetailsState initialState) : super(initialState);

  Future<void> fetchUserDetails() async {
    try {
      var response = await Dio().get('http://ip-api.com/json');
      if (response != null && response.statusCode == 200) {
        if (response.data != null) {
          UserDetails details = UserDetails.fromJson(response.data);
          emit(FetchUserDetailsLoadedState(data: details));
        } else {
          emit(FetchUserDetailsErrorState(error: "Body empty"));
        }
      } else {
        emit(FetchUserDetailsErrorState(error: "Got invalid rsponse from api"));
      }
    } catch (e) {
      print("eroor $e");
      emit(FetchUserDetailsErrorState(error: "Request failed"));
    }
  }
}
