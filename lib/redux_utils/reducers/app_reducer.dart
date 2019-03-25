import 'package:lhs_connections/redux_utils/app_state.dart';
import 'package:lhs_connections/redux_utils/reducers/counter_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: false,
    count: counterReducer(state.count, action),
  );
}