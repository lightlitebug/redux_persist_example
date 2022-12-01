import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  final String author;
  final String content;
  const Quote({
    required this.author,
    required this.content,
  });

  Quote copyWith({
    String? author,
    String? content,
  }) {
    return Quote(
      author: author ?? this.author,
      content: content ?? this.content,
    );
  }

  dynamic toJson() {
    final result = <String, dynamic>{};

    result.addAll({'author': author});
    result.addAll({'content': content});

    return result;
  }

  static Quote fromJson(dynamic json) {
    return Quote(
      author: json['author'] ?? '',
      content: json['content'] ?? '',
    );
  }

  @override
  String toString() => 'Quote(author: $author, content: $content)';

  @override
  List<Object> get props => [author, content];
}
