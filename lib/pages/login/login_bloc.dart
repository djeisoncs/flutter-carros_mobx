
import 'dart:async';

import 'package:carros/bloc/boolean_bloc.dart';
import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/api_response.dart';

import 'login_api.dart';

class LoginBloc extends BooleanBloc {

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}