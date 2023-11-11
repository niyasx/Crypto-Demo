import 'usd.dart';

/// Represents the quote information for a cryptocurrency, including price data in USD.
class Quote {
  /// Price data for USD.
  Usd? usd;

  /// Constructor for the `Quote` class.
  Quote({this.usd});

  /// Creates a `Quote` object from a JSON map.
  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        usd: json['USD'] == null
            ? null
            : Usd.fromJson(json['USD'] as Map<String, dynamic>),
      );

  /// Converts the `Quote` object to a JSON map.
  Map<String, dynamic> toJson() => {
        'USD': usd?.toJson(),
      };
}
