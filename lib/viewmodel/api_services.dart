
// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:async';
import 'package:gweiland_flutter_task/model/crypto_model/crypto_model.dart';
import 'package:http/http.dart' as http;


// ApiServices Class
//
// This class handles the communication with the CoinMarketCap API to fetch
// the latest cryptocurrency data. It utilizes a StreamController to provide
// a stream of CryptoModel objects to its listeners.

class ApiServices {
  final _cryptoController = StreamController<CryptoModel>();

  // Getter for the crypto data stream
  Stream<CryptoModel> get cryptoStream => _cryptoController.stream;

  // fetchCryptoData Function
  //
  // This function makes an HTTP GET request to the CoinMarketCap API to fetch
  // the latest cryptocurrency data. It expects a response in JSON format,
  // parses it into a CryptoModel object, and adds it to the stream.


  // Throws:
  // - If the API request fails or encounters an error, it prints an error message.

  Future<void> fetchCryptoData() async {
    const apiKey = "07a410c2-a3a6-46d9-863a-57dd91c3858e";
    final url = Uri.https(
      'pro-api.coinmarketcap.com',
      '/v1/cryptocurrency/listings/latest',
      {'start': '1', 'limit': '25', 'convert': 'USD'},
    );

    try {
      final response = await http.get(url, headers: {'X-CMC_PRO_API_KEY': apiKey});
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _cryptoController.add(CryptoModel.fromJson(data));
      } else {
        print("API request failed");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  // dispose Function
  //
  // This function closes the stream controller when it's no longer needed.
  //

  void dispose() {
    _cryptoController.close();
  }
}
