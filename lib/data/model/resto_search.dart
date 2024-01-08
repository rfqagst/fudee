// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

Temperatures temperaturesFromJson(String str) => Temperatures.fromJson(json.decode(str));

String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Temperatures {
    bool error;
    int founded;
    List<Restaurant> restaurants;

    Temperatures({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class Restaurant {
    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
