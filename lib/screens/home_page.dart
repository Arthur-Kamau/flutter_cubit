import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/state/home_cubit.dart';
import 'package:flutter_cubit/state/home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDetailsCubit _userDetailsCubit =
      UserDetailsCubit(FetchUserDetailsInitialState());

  @override
  void initState() {
    super.initState();
    // Create anonymous function:
    // async functions not allowed in constructor
    () async {
      await _userDetailsCubit.fetchUserDetails();
    }();
  }

  @override
  void dispose() {
    super.dispose();
    _userDetailsCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc with cubit example"),
      ),
      body: BlocProvider(
        create: (context) {
          return _userDetailsCubit;
        },
        child: BlocListener<UserDetailsCubit, UserDetailsState>(
          listener: (context, state) async {
            if (state is FetchUserDetailsLoadedState) {
              print("perform action when a state is detected");
            }
          },
          child: BlocBuilder<UserDetailsCubit, UserDetailsState>(
            builder: (context, state) {
              if (state is FetchUserDetailsInitialState ||
                  state is FetchUserDetailsLoadingState) {
                return Center(
                  child: Text("Loading user details"),
                );
              }
              if (state is FetchUserDetailsErrorState) {
                return Center(
                  child: Text("Error : ${state.error}"),
                );
              }

              if (state is FetchUserDetailsLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("User ip  :   "),
                        Text(state.data.query),
                      ],
                    ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10),
                       child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("User region  :   "),
                          Text(state.data.regionName),
                        ],
                    ),
                     ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
