import 'dart:convert';

class Verses {
  int? book;
  int? chapter;
  dynamic verseNumber;
  String? verseText;
  int? highlight = 0;
  Verses({
    this.book,
    this.chapter,
    this.verseNumber,
    this.verseText,
    this.highlight,
  });

  Verses copyWith({
    int? book,
    int? chapter,
    int? verseNumber,
    String? para,
    String? verseText,
    int? highlight,
  }) {
    return Verses(
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verseNumber: verseNumber ?? this.verseNumber,
      verseText: verseText ?? this.verseText,
      highlight: highlight ?? this.highlight,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (book != null) {
      result.addAll({'book': book});
    }
    if (chapter != null) {
      result.addAll({'chapter': chapter});
    }
    if (verseNumber != null) {
      result.addAll({'verseNumber': verseNumber});
    }
   
    if (verseText != null) {
      result.addAll({'verseText': verseText});
    }
    if (highlight != null) {
      result.addAll({'highlight': highlight});
    }

    return result;
  }

  factory Verses.fromMap(Map<String, dynamic> map) {
    return Verses(
      book: map['book']?.toInt(),
      chapter: map['chapter']?.toInt(),
      verseNumber: map['verseNumber']?.toInt(),
      verseText: map['verseText'],
      highlight: map['highlight'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Verses.fromJson(String source) => Verses.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VersesAMH(book: $book, chapter: $chapter, verseNumber: $verseNumber,  verseText: $verseText, highlight: $highlight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Verses &&
        other.book == book &&
        other.chapter == chapter &&
        other.verseNumber == verseNumber &&
        other.verseText == verseText &&
        other.highlight == highlight;
  }

  @override
  int get hashCode {
    return book.hashCode ^
        chapter.hashCode ^
        verseNumber.hashCode ^
        verseText.hashCode ^
        highlight.hashCode;
  }
}
