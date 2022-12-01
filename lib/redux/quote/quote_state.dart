import 'package:equatable/equatable.dart';

import '../../models/quote.dart';

enum QuoteStatus {
  initial,
  loading,
  success,
  failure;

  String toJson() => name;

  static QuoteStatus fromJson(String json) => values.byName(json);
}

class QuoteState extends Equatable {
  final QuoteStatus quoteStatus;
  final Quote quote;
  final String error;
  const QuoteState({
    required this.quoteStatus,
    required this.quote,
    required this.error,
  });

  factory QuoteState.initial() {
    return const QuoteState(
      quoteStatus: QuoteStatus.initial,
      quote: Quote(author: '', content: ''),
      error: '',
    );
  }

  @override
  List<Object> get props => [quoteStatus, quote, error];

  @override
  String toString() =>
      'QuoteState(quoteStatus: $quoteStatus, quote: $quote, error: $error)';

  QuoteState copyWith({
    QuoteStatus? quoteStatus,
    Quote? quote,
    String? error,
  }) {
    return QuoteState(
      quoteStatus: quoteStatus ?? this.quoteStatus,
      quote: quote ?? this.quote,
      error: error ?? this.error,
    );
  }

  dynamic toJson() {
    final result = <String, dynamic>{};

    result.addAll({'quoteStatus': quoteStatus.toJson()});
    result.addAll({'quote': quote.toJson()});
    result.addAll({'error': error});

    return result;
  }

  static QuoteState fromJson(dynamic json) {
    return QuoteState(
      quoteStatus: QuoteStatus.fromJson(json['quoteStatus']),
      quote: Quote.fromJson(json['quote']),
      error: json['error'] ?? '',
    );
  }
}
