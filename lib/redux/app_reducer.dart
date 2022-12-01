import 'app_state.dart';
import 'counter/counter_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    counterState: counterReducer(state.counterState, action),
  );
}
