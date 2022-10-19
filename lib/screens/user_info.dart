import 'package:ecommerce/widgets/basic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc/user_bloc.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: ((context) => _userBloc),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(builder: ((context, state) {
          if (state is UserInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoaded) {
            return displayProfile(state.user, context);
          } else if (state is UserError) {
            return const Center(
              child: Text('something is wrong'),
            );
          } else {
            return Container(
              color: Colors.red,
            );
          }
        })),
      ),
    ));
  }
}
