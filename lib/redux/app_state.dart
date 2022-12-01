import 'package:equatable/equatable.dart';

import 'counter/counter_state.dart';

class AppState extends Equatable {
  final CounterState counterState;
  const AppState({
    required this.counterState,
  });

  factory AppState.initial() {
    return AppState(
      counterState: CounterState.initial(),
    );
  }

  @override
  List<Object> get props => [counterState];

  @override
  String toString() => 'AppState(counterState: $counterState)';

  AppState copyWith({
    CounterState? counterState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
    );
  }

  dynamic toJson() {
    final counterJson = counterState.toJson();

    return {
      'counterState': counterJson,
    };
  }

  static AppState? fromJson(dynamic json) {
    if (json == null) return null;

    return AppState(
      counterState: CounterState.fromJson(json['counterState']),
    );
  }
}
