import 'package:flutter/material.dart';
import 'package:fudee/data/api/api_service.dart';
import 'package:fudee/data/model/resto_data.dart';
import 'package:fudee/data/model/resto_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestoData _restoData;
  late RestoDetail _restoDetail;
  late ResultState _state;
  String _message = '';
  String get message => _message;

  RestoData get result => _restoData;
  RestoDetail get resultDetail => _restoDetail;

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
      return _message = 'Error --> $e';
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
      return _message = 'Error --> $e';
    }
  }
}
