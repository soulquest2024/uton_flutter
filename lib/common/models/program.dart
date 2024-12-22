
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

//TODO call: flutter packages pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(includeIfNull: false)
class Program {
  String? id;
  int? shrineId;
  String? title;
  String? date;
  String? location;
  GeoPoint? coordinates;
  String? category;
  String? image;
  String? shortText;
  String? program;
  String? description;
  String? url;

  Program({
    this.id,
    this.shrineId,
    this.title,
    this.date,
    this.location,
    this.coordinates,
    this.category,
    this.image,
    this.shortText,
    this.program,
    this.description,
    this.url,
  });

  Program.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    id = doc.id;
    shrineId = doc['shrineId'];
    title = doc['title'];
    date = doc['date'];
    location = doc['location'];
    if (doc['geopoint'] is GeoPoint) {
      coordinates = doc['geopoint'];
    }
    category = doc['category'];
    image = doc['image'];
    shortText = doc['shortText'];
    program = doc['program'];
    description = doc['description'];
    url = doc['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shrineId': shrineId,
      'title': title,
      'date': date,
      'location': location,
      'coordinates': coordinates,
      'category': category,
      'image': image,
      'shortText': shortText,
      'program': program,
      'description': description,
      'url': url,
    };
  }
}

