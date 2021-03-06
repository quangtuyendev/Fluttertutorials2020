import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginwithbloc/blocs/authentication_bloc.dart';
import 'package:loginwithbloc/blocs/login_bloc.dart';
import 'package:loginwithbloc/events/login_event.dart';
import 'package:loginwithbloc/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginwithbloc/states/login_state.dart';

class LoginPage extends StatefulWidget {
  //because it has TextField(input email, password)
  final UserRepository userRepository;
  LoginPage({this.userRepository});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}
class _LoginPage extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        final loginBloc = LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: widget.userRepository
        );
        return loginBloc;
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'email'),
                        controller: _emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'password'),
                        controller: _passwordController,
                      ),
                      Container(
                        child: SizedBox(
                          width: 200, height: 45,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(LoginEventButtonPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                            },
                            child: Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
            )
          );
        },
      ),
    );
  }
}