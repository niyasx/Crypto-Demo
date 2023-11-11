
// CryptoModel Class
//
// This class represents the model for cryptocurrency data. It consists of
// two main properties: 'status' and 'data'. 'status' contains information
// about the success or failure of the API request, while 'data' holds a list
// of Datum objects representing individual cryptocurrencies.

import 'datum.dart'; // Importing Datum class
import 'status.dart'; // Importing Status class

class CryptoModel {
  // Status object representing the success or failure of the API request.
  Status? status;

  // List of Datum objects representing individual cryptocurrencies.
  List<Datum>? data;

  // Constructor
  CryptoModel({this.status, this.data});

  // Factory Constructor from JSON
  //
  // This constructor creates a CryptoModel instance from a JSON map.
  // It takes a Map<String, dynamic> as input and returns a CryptoModel object.
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // toJson Method
  //
  // This method converts the CryptoModel object to a JSON map.
  // It returns a Map<String, dynamic>.
  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
