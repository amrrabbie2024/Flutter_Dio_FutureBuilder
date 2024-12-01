import 'package:dio/dio.dart';
import 'package:flutter_dio_futurebuilder/model/news_model.dart';
import 'package:flutter_dio_futurebuilder/model/weather_model.dart';

import 'constants.dart';

class ApiServices {
  Future<NewsData?> fetchNewsData(String category) async {
    Dio dio = Dio();
    var response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=${Constants.NewsCountry}&apiKey=${Constants.NewsApiKey}&category=$category&page=1');
    if (response.statusCode == 200) {
      return  NewsData.fromJson(response.data);
    }
    return null;
  }

  Future<WeatherData?> fetchWeatherData(String city) async {
    Dio dio = Dio();
    var response = await dio.get(
        'http://api.weatherapi.com/v1/forecast.json?key=${Constants.WeatherApiKey}&q=$city&days=1&aqi=no&alerts=no');
    if (response.statusCode == 200) {
      return  WeatherData.fromJson(response.data);
    }
    return null;
  }
}