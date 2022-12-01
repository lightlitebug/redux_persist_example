import 'app_state.dart';
import 'counter/counter_reducer.dart';
import 'quote/quote_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    counterState: counterReducer(state.counterState, action),
    quoteState: quoteReducer(state.quoteState, action),
  );
}
