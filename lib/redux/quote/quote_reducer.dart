import 'package:redux/redux.dart';

import 'quote_action.dart';
import 'quote_state.dart';

QuoteState getQuoteReducer(
  QuoteState state,
  GetQuoteAction action,
) {
  return state.copyWith(quoteStatus: QuoteStatus.loading);
}

QuoteState getQuoteSucceededReducer(
  QuoteState state,
  GetQuoteSucceededAction action,
) {
  return state.copyWith(
    quoteStatus: QuoteStatus.success,
    quote: action.quote,
  );
}

QuoteState getQuoteFailedReducer(
  QuoteState state,
  GetQuoteFailedAction action,
) {
  return state.copyWith(
    quoteStatus: QuoteStatus.failure,
    error: action.error,
  );
}

Reducer<QuoteState> quoteReducer = combineReducers<QuoteState>([
  TypedReducer<QuoteState, GetQuoteAction>(getQuoteReducer),
  TypedReducer<QuoteState, GetQuoteSucceededAction>(
    getQuoteSucceededReducer,
  ),
  TypedReducer<QuoteState, GetQuoteFailedAction>(
    getQuoteFailedReducer,
  ),
]);
