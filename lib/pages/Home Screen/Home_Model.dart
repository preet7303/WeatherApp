//I have used Hive to store the search history of cities
//Hive is also used to display the previously searched Cities
//This is model Class created for hive

import 'dart:ffi';

import 'package:hive/hive.dart';

part 'Home_Model.g.dart';

@HiveType(typeId: 0)
class SearchSave {
  @HiveField(0)
  final String cityName;

  const SearchSave(this.cityName);
}
