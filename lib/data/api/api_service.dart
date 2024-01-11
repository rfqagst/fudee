import 'dart:convert';
import 'package:fudee/data/model/resto_detail.dart';
import 'package:fudee/data/model/resto_search.dart';
import 'package:http/http.dart' as http;
import 'package:fudee/data/model/resto_data.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestoData> getRestoList() async {
    final url = Uri.parse('${_baseUrl}list');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return RestoData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  Future<RestoDetail> getRestoDetail(String id) async {
    final url = Uri.parse("$_baseUrl/detail/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return RestoDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  Future<RestoSearch> searchRestaurants(String query) async {
    final url = Uri.parse('$_baseUrl/search?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return RestoSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load search data');
    }
  }
}
