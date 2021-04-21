import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit/models/user_details.dart';

// equitable helps in comparison(especialy in tests)
abstract class UserDetailsState extends Equatable {
  const UserDetailsState();
  @override
  List<Object> get props => [];
}

class FetchUserDetailsInitialState extends UserDetailsState {}

class FetchUserDetailsErrorState extends UserDetailsState {
  final String error;

  FetchUserDetailsErrorState({@required this.error});
  @override
  List<Object> get props => [
        error,
      ];
}

class FetchUserDetailsLoadingState extends UserDetailsState {
  const FetchUserDetailsLoadingState();
}

class FetchUserDetailsLoadedState extends UserDetailsState {
  final UserDetails data;

  FetchUserDetailsLoadedState({@required this.data});
  @override
  List<Object> get props => [
        data,
      ];
}
