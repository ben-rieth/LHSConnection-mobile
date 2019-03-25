import 'package:lhs_connections/redux_utils/actions/counter_actions.dart';

int counterReducer(int currentCount, action) {
  if(action is IncrementsCountAction) {
    currentCount++;
    return currentCount;
  } else if (action is DecrementCountAction) {
    currentCount--;
    return currentCount;
  } else {
    return currentCount;
  }
}