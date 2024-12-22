
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

//TODO call: flutter packages pub run build_runner build --delete-conflicting-outputs

@JsonSerializable(includeIfNull: false)
class Offer {
  String? id;
  String? accomodation;
  String? category;
  String? date;
  int? days;
  String? image;
  List<String>? labels;
  int? offerId;
  int? offerType;
  int? price;
  String? quarters;
  String? spiritualGuide;
  String? title;
  String? travelAgency;
  String? trip;
  String? url;

  Offer({
    this.id,
    this.accomodation,
    this.category,
    this.date,
    this.days,
    this.image,
    this.labels,
    this.offerId,
    this.offerType,
    this.price,
    this.quarters,
    this.spiritualGuide,
    this.title,
    this.travelAgency,
    this.trip,
    this.url,
  });

  Offer.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    id = doc.id;
    accomodation = doc['accomodation'];
    category = doc['category'];
    date = doc['date'];
    image = doc['image'];
    labels = List<String>.from(doc['labels'] ?? []);
    offerId = doc['offerId'];
    offerType = doc['offerType'];
    price = doc['price'];
    quarters = doc['quarters'];
    spiritualGuide = doc['spiritualGuide'];
    title = doc['title'];
    travelAgency = doc['travelAgency'];
    trip = doc['trip'];
    url = doc['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accomodation': accomodation,
      'category': category,
      'date': date,
      'days': days,
      'image': image,
      'labels': labels,
      'offerId': offerId,
      'offerType': offerType,
      'price': price,
      'quarters': quarters,
      'spiritualGuide': spiritualGuide,
      'title': title,
      'travelAgency': travelAgency,
      'trip': trip,
      'url': url,
    };
  }
}

