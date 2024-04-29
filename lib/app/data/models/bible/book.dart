import 'dart:convert';

class Book {
  int? id;
  String? name;
  String? nameGeez;
  String? title;
  String? titleGeez;
  String? titleGeezShort;
  int? chapters;
  String? testament;
  Book({
    this.id,
    this.name,
    this.nameGeez,
    this.title,
    this.titleGeez,
    this.titleGeezShort,
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
      nameGeez: nameGeez ?? this.nameGeez,
      title: title ?? this.title,
      titleGeez: titleGeez ?? this.titleGeez,
      titleGeezShort: titleGeezShort ?? this.titleGeezShort,
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
    if (nameGeez != null) {
      result.addAll({'nameGeez': nameGeez});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (titleGeez != null) {
      result.addAll({'titleGeez': titleGeez});
    }
    if (titleGeezShort != null) {
      result.addAll({'titleGeezShort': titleGeezShort});
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
      nameGeez: map['nameGeez'],
      title: map['title'],
      titleGeez: map['titleGeez'],
      titleGeezShort: map['titleGeezShort'],
      chapters: map['chapters']?.toInt(),
      testament: map['testament'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(id: $id, name: $name, nameGeez: $nameGeez, title: $title, titleGeez: $titleGeez, titleGeezShort: $titleGeezShort, chapters: $chapters, testament: $testament)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Book &&
        other.id == id &&
        other.name == name &&
        other.nameGeez == nameGeez &&
        other.title == title &&
        other.titleGeez == titleGeez &&
        other.titleGeezShort == titleGeezShort &&
        other.chapters == chapters &&
        other.testament == testament;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        nameGeez.hashCode ^
        title.hashCode ^
        titleGeez.hashCode ^
        titleGeezShort.hashCode ^
        chapters.hashCode ^
        testament.hashCode;
  }
}
