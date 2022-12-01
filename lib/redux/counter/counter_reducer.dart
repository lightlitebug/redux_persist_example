import 'package:redux/redux.dart';

import 'counter_action.dart';
import 'counter_state.dart';

CounterState incrementReducer(
  CounterState state,
  IncrementAction action,
) {
  return state.copyWith(counter: state.counter + 1);
}

CounterState decrementReducer(
  CounterState state,
  DecrementAction action,
) {
  return state.copyWith(counter: state.counter - 1);
}

Reducer<CounterState> counterReducer = combineReducers<CounterState>([
  TypedReducer<CounterState, IncrementAction>(incrementReducer),
  TypedReducer<CounterState, DecrementAction>(decrementReducer),
]);
