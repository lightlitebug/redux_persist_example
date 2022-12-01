import 'package:equatable/equatable.dart';

import 'counter/counter_state.dart';
import 'quote/quote_state.dart';

class AppState extends Equatable {
  final CounterState counterState;
  final QuoteState quoteState;
  const AppState({
    required this.counterState,
    required this.quoteState,
  });

  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
      quoteState: QuoteState.initial(),
    );
  }

  @override
  List<Object> get props => [counterState, quoteState];

  @override
  String toString() =>
      'AppState(counterState: $counterState, quoteState: $quoteState)';

  AppState copyWith({
    CounterState? counterState,
    QuoteState? quoteState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      quoteState: quoteState ?? this.quoteState,
    );
  }

  dynamic toJson() {
    final counterJson = counterState.toJson();
    final quoteJson = quoteState.toJson();

    return {
      'counterState': counterJson,
      'quoteState': quoteJson,
    };
  }

  static AppState? fromJson(dynamic json) {
    if (json == null) return null;

    return AppState(
      counterState: CounterState.fromJson(json['counterState']),
      quoteState: QuoteState.fromJson(json['quoteState']),
    );
  }
}
