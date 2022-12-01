import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/quote.dart';
import '../app_state.dart';

class GetQuoteAction {
  @override
  String toString() => 'GetQuoteAction()';
}

class GetQuoteSucceededAction {
  final Quote quote;
  GetQuoteSucceededAction({
    required this.quote,
  });

  @override
  String toString() => 'GetQuoteSucceededAction(quote: $quote)';
}

class GetQuoteFailedAction {
  final String error;
  GetQuoteFailedAction({
    required this.error,
  });

  @override
  String toString() => 'GetQuoteFailedAction(error: $error)';
}

ThunkAction<AppState> getQuoteAndDispatch() {
  return (Store<AppState> store) async {
    store.dispatch(GetQuoteAction());

    try {
      Uri url = Uri.https('api.quotable.io', '/random');
      final http.Response response = await http.get(url);
      final jsonData = jsonDecode(response.body);
      final Quote quote = Quote.fromJson(jsonData);

      store.dispatch(GetQuoteSucceededAction(quote: quote));
    } catch (e) {
      store.dispatch(GetQuoteFailedAction(error: e.toString()));
    }
  };
}
