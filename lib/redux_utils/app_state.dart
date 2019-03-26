import 'package:firebase_auth/firebase_auth.dart';

class AppState {
  final bool isLoading;
  final FirebaseUser currentUser;

  AppState({ this.isLoading = false, this.currentUser});

  AppState copyWith({int count, bool isLoading}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() {
    return "AppState{isLoading: $isLoading, currentUser: $currentUser}";
  }
}