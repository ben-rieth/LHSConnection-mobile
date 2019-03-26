import 'package:lhs_connections/redux_utils/app_state.dart';
import 'package:lhs_connections/redux_utils/reducers/auth_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: false,
    currentUser: authReducer(state.currentUser, action),
  );
}