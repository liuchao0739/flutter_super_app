import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 简单的全局认证状态，供登录页和设置页使用。
class AuthState {
  final bool isLoggedIn;
  final String? username;

  const AuthState({required this.isLoggedIn, this.username});

  AuthState copyWith({bool? isLoggedIn, String? username}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      username: username ?? this.username,
    );
  }

  static const empty = AuthState(isLoggedIn: false);
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState.empty);

  Future<void> login({required String username, required String password}) async {
    // TODO(prod): 接入真实登录接口，并处理 token/错误码
    await Future.delayed(const Duration(milliseconds: 300));
    state = AuthState(isLoggedIn: true, username: username);
  }

  Future<void> logout() async {
    // TODO(prod): 调用登出接口、清理本地凭证
    await Future.delayed(const Duration(milliseconds: 100));
    state = AuthState.empty;
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});


