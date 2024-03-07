import 'dart:convert';

class Book {
  int? id;
  String? name;
  String? title;
  int? chapters;
  String? testament;
  Book({
    this.id,
    this.name,
    this.title,
    this.chapters,
    this.testament,
  });

  Book copyWith({
    int? id,
    String? name,
    String? nameGeez,
    String? title,
    String? titleGeez,
    String? titleGeezShort,
    int? chapters,
    String? testament,
  }) {
    return Book(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      chapters: chapters ?? this.chapters,
      testament: testament ?? this.testament,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }

    if (title != null) {
      result.addAll({'title': title});
    }

    if (chapters != null) {
      result.addAll({'chapters': chapters});
    }
    if (testament != null) {
      result.addAll({'testament': testament});
    }

    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']?.toInt(),
      name: map['name'],
      title: map['title'],
      chapters: map['chapters']?.toInt(),
      testament: map['testament'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(id: $id, name: $name,  title: $title,   chapters: $chapters, testament: $testament)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.name == name &&
        other.title == title &&
        other.chapters == chapters &&
        other.testament == testament;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        title.hashCode ^
        chapters.hashCode ^
        testament.hashCode;
  }
}
