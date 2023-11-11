import 'quote.dart';


/// Represents cryptocurrency data for a specific coin.
class Datum {
  /// The unique identifier for the cryptocurrency.
  int? id;

  /// The name of the cryptocurrency.
  String? name;

  /// The symbol representing the cryptocurrency.
  String? symbol;

  /// The slug used in the URL for the cryptocurrency.
  String? slug;

  /// The number of market pairs for the cryptocurrency.
  int? numMarketPairs;

  /// The date when the cryptocurrency was added.
  DateTime? dateAdded;

  /// Tags associated with the cryptocurrency.
  List<dynamic>? tags;

  /// The maximum supply of the cryptocurrency.
  int? maxSupply;

  /// The circulating supply of the cryptocurrency.
  double? circulatingSupply;

  /// The total supply of the cryptocurrency.
  double? totalSupply;

  /// Indicates whether the cryptocurrency has an infinite supply.
  bool? infiniteSupply;

  /// The platform associated with the cryptocurrency.
  dynamic platform;

  /// The CoinMarketCap rank of the cryptocurrency.
  int? cmcRank;

  /// Self-reported circulating supply of the cryptocurrency.
  dynamic selfReportedCirculatingSupply;

  /// Self-reported market cap of the cryptocurrency.
  dynamic selfReportedMarketCap;

  /// TVL (Total Value Locked) ratio for the cryptocurrency.
  dynamic tvlRatio;

  /// The date when the cryptocurrency data was last updated.
  DateTime? lastUpdated;

  /// Quote information for the cryptocurrency, including price data.
  Quote? quote;

  /// Constructor for the `Datum` class.
  Datum({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.numMarketPairs,
    this.dateAdded,
    this.tags,
    this.maxSupply,
    this.circulatingSupply,
    this.totalSupply,
    this.infiniteSupply,
    this.platform,
    this.cmcRank,
    this.selfReportedCirculatingSupply,
    this.selfReportedMarketCap,
    this.tvlRatio,
    this.lastUpdated,
    this.quote,
  });

  /// Creates a `Datum` object from a JSON map.
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        symbol: json['symbol'] as String?,
        slug: json['slug'] as String?,
        numMarketPairs: json['num_market_pairs'] as int?,
        dateAdded: json['date_added'] == null
            ? null
            : DateTime.parse(json['date_added'] as String),
        tags: json['tags'] as List<dynamic>?,
        maxSupply: json['max_supply'] as int?,
        circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
        totalSupply: (json['total_supply'] as num?)?.toDouble(),
        infiniteSupply: json['infinite_supply'] as bool?,
        platform: json['platform'] as dynamic,
        cmcRank: json['cmc_rank'] as int?,
        selfReportedCirculatingSupply:
            json['self_reported_circulating_supply'] as dynamic,
        selfReportedMarketCap: json['self_reported_market_cap'] as dynamic,
        tvlRatio: json['tvl_ratio'] as dynamic,
        lastUpdated: json['last_updated'] == null
            ? null
            : DateTime.parse(json['last_updated'] as String),
        quote: json['quote'] == null
            ? null
            : Quote.fromJson(json['quote'] as Map<String, dynamic>),
      );

  /// Converts the `Datum` object to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'slug': slug,
        'num_market_pairs': numMarketPairs,
        'date_added': dateAdded?.toIso8601String(),
        'tags': tags,
        'max_supply': maxSupply,
        'circulating_supply': circulatingSupply,
        'total_supply': totalSupply,
        'infinite_supply': infiniteSupply,
        'platform': platform,
        'cmc_rank': cmcRank,
        'self_reported_circulating_supply': selfReportedCirculatingSupply,
        'self_reported_market_cap': selfReportedMarketCap,
        'tvl_ratio': tvlRatio,
        'last_updated': lastUpdated?.toIso8601String(),
        'quote': quote?.toJson(),
      };
}
