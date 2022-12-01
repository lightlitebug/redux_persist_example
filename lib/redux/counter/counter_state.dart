import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({
    required this.counter,
  });

  factory CounterState.initial() {
    return const CounterState(counter: 0);
  }

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }

  dynamic toJson() {
    return {'counter': counter};
  }

  static CounterState fromJson(dynamic json) {
    return CounterState(
      counter: json['counter']?.toInt() ?? 0,
    );
  }
}
