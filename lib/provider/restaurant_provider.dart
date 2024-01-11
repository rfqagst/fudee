import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fudee/data/api/api_service.dart';
import 'package:fudee/data/model/resto_data.dart';
import 'package:fudee/data/model/resto_detail.dart';
import 'package:fudee/data/model/resto_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestoData _restoData;
  late RestoSearch _restoSearch;

  late RestoDetail _restoDetail;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  RestoData get result => _restoData;
  RestoDetail get resultDetail => _restoDetail;
  RestoSearch get restoSearch => _restoSearch;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.getRestoList();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoData = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message =
            "Tidak dapat terhubung ke internet. Silakan periksa koneksi jaringan Anda.";
      } else if (e is FormatException) {
        return _message =
            "Data yang diterima tidak valid. Silakan coba lagi nanti.";
      } else if (e is HttpException) {
        return _message =
            "Tidak dapat menemukan informasi yang diminta. Silakan periksa kembali atau coba lagi nanti.";
      } else {
        return _message = "Terjadi kesalahan. Silakan coba lagi nanti.";
      }
    }
  }

  Future<void> fetchRestaurantDetails(String id) async {
    await _fetchDetailRestaurant(id);
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailResto = await apiService.getRestoDetail(id);
      if (detailResto.restaurant.name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoDetail = detailResto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message =
            "Tidak dapat terhubung ke internet. Silakan periksa koneksi jaringan Anda.";
      } else if (e is FormatException) {
        return _message =
            "Data yang diterima tidak valid. Silakan coba lagi nanti.";
      } else if (e is HttpException) {
        return _message =
            "Tidak dapat menemukan informasi yang diminta. Silakan periksa kembali atau coba lagi nanti.";
      } else {
        return _message = "Terjadi kesalahan. Silakan coba lagi nanti.";
      }
    }
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.searchRestaurants(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return;
      }
      _state = ResultState.hasData;
      _restoSearch = result;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message =
            "Tidak dapat terhubung ke internet. Silakan periksa koneksi jaringan Anda.";
      } else if (e is FormatException) {
        return _message =
            "Data yang diterima tidak valid. Silakan coba lagi nanti.";
      } else if (e is HttpException) {
        return _message =
            "Tidak dapat menemukan informasi yang diminta. Silakan periksa kembali atau coba lagi nanti.";
      } else {
        return _message = "Terjadi kesalahan. Silakan coba lagi nanti.";
      }
    }
  }
}
