/// Represents the USD details for a cryptocurrency, including price, volume, and percentage changes.
class Usd {
  /// Current price of the cryptocurrency in USD.
  double? price;

  /// 24-hour trading volume in USD.
  double? volume24h;

  /// Percentage change in volume over the last 24 hours.
  double? volumeChange24h;

  /// Percentage change in price over the last 1 hour.
  double? percentChange1h;

  /// Percentage change in price over the last 24 hours.
  double? percentChange24h;

  /// Percentage change in price over the last 7 days.
  double? percentChange7d;

  /// Percentage change in price over the last 30 days.
  double? percentChange30d;

  /// Percentage change in price over the last 60 days.
  double? percentChange60d;

  /// Percentage change in price over the last 90 days.
  double? percentChange90d;

  /// Market capitalization of the cryptocurrency in USD.
  double? marketCap;

  /// Dominance of the cryptocurrency's market cap.
  double? marketCapDominance;

  /// Fully diluted market capitalization in USD.
  double? fullyDilutedMarketCap;

  /// Total Value Locked (TVL), if available.
  dynamic tvl;

  /// Last updated timestamp for the USD details.
  DateTime? lastUpdated;

  /// Constructor for the `Usd` class.
  Usd({
    this.price,
    this.volume24h,
    this.volumeChange24h,
    this.percentChange1h,
    this.percentChange24h,
    this.percentChange7d,
    this.percentChange30d,
    this.percentChange60d,
    this.percentChange90d,
    this.marketCap,
    this.marketCapDominance,
    this.fullyDilutedMarketCap,
    this.tvl,
    this.lastUpdated,
  });

  /// Creates a `Usd` object from a JSON map.
  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: (json['price'] as num?)?.toDouble(),
        volume24h: (json['volume_24h'] as num?)?.toDouble(),
        volumeChange24h: (json['volume_change_24h'] as num?)?.toDouble(),
        percentChange1h: (json['percent_change_1h'] as num?)?.toDouble(),
        percentChange24h: (json['percent_change_24h'] as num?)?.toDouble(),
        percentChange7d: (json['percent_change_7d'] as num?)?.toDouble(),
        percentChange30d: (json['percent_change_30d'] as num?)?.toDouble(),
        percentChange60d: (json['percent_change_60d'] as num?)?.toDouble(),
        percentChange90d: (json['percent_change_90d'] as num?)?.toDouble(),
        marketCap: (json['market_cap'] as num?)?.toDouble(),
        marketCapDominance: (json['market_cap_dominance'] as num?)?.toDouble(),
        fullyDilutedMarketCap: (json['fully_diluted_market_cap'] as num?)?.toDouble(),
        tvl: json['tvl'] as dynamic,
        lastUpdated: json['last_updated'] == null
            ? null
            : DateTime.parse(json['last_updated'] as String),
      );

  /// Converts the `Usd` object to a JSON map.
  Map<String, dynamic> toJson() => {
        'price': price,
        'volume_24h': volume24h,
        'volume_change_24h': volumeChange24h,
        'percent_change_1h': percentChange1h,
        'percent_change_24h': percentChange24h,
        'percent_change_7d': percentChange7d,
        'percent_change_30d': percentChange30d,
        'percent_change_60d': percentChange60d,
        'percent_change_90d': percentChange90d,
        'market_cap': marketCap,
        'market_cap_dominance': marketCapDominance,
        'fully_diluted_market_cap': fullyDilutedMarketCap,
        'tvl': tvl,
        'last_updated': lastUpdated?.toIso8601String(),
      };
}
