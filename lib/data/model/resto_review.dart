// To parse this JSON data, do
//
//     final RestoReview = RestoReviewFromJson(jsonString);

import 'dart:convert';

RestoReview restoReviewFromJson(String str) => RestoReview.fromJson(json.decode(str));

String restoReviewToJson(RestoReview data) => json.encode(data.toJson());

class RestoReview {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    RestoReview({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory RestoReview.fromJson(Map<String, dynamic> json) => RestoReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class CustomerReview {
    String name;
    String review;
    String date;

    CustomerReview({
        required this.name,
        required this.review,
        required this.date,
    });

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}
