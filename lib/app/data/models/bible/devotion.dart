// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Devotion {
  int? id;
  String? date;
  String? verse;
  String? verseLocation;
  String? verseDescription;
  String? versePrayer;
  Devotion({
    this.id,
    this.date,
    this.verse,
    this.verseLocation,
    this.verseDescription,
    this.versePrayer,
  });

  Devotion copyWith({
    int? id,
    String? date,
    String? verse,
    String? verseLocation,
    String? verseDescription,
    String? versePrayer,
  }) {
    return Devotion(
      id: id ?? this.id,
      date: date ?? this.date,
      verse: verse ?? this.verse,
      verseLocation: verseLocation ?? this.verseLocation,
      verseDescription: verseDescription ?? this.verseDescription,
      versePrayer: versePrayer ?? this.versePrayer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'verse': verse,
      'verseLocation': verseLocation,
      'verseDescription': verseDescription,
      'versePrayer': versePrayer,
    };
  }

  factory Devotion.fromMap(Map<String, dynamic> map) {
    return Devotion(
      id: map['id'] != null ? map['id'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      verse: map['verse'] != null ? map['verse'] as String : null,
      verseLocation:
          map['verseLocation'] != null ? map['verseLocation'] as String : null,
      verseDescription: map['verseDescription'] != null
          ? map['verseDescription'] as String
          : null,
      versePrayer:
          map['versePrayer'] != null ? map['versePrayer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Devotion.fromJson(String source) =>
      Devotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Devotion(id: $id, date: $date, verse: $verse, verseLocation: $verseLocation, verseDescription: $verseDescription, versePrayer: $versePrayer)';
  }

  @override
  bool operator ==(covariant Devotion other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.verse == verse &&
        other.verseLocation == verseLocation &&
        other.verseDescription == verseDescription &&
        other.versePrayer == versePrayer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        verse.hashCode ^
        verseLocation.hashCode ^
        verseDescription.hashCode ^
        versePrayer.hashCode;
  }
}
