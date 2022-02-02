import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:untitled2/app/core/constants/request_routes.dart';
import 'package:untitled2/app/core/dio/dio_factory.dart';
import 'package:untitled2/app/core/exceptions/exceptions.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_model.dart';
import 'package:untitled2/app/modules/home/pokemon_details/pokemon_details_model.dart';

class HomeRepository{

  Future<List<Result>> getPokemon(int limit)async{
    try{
      final response = await DioHelper.getData(
          url: RequestRoutes.getData,
          query: {
            'limit':limit,
            'offset':200
          }
      );
      return pokemonFromJson(response.data['results']);
    }catch(error){
      throw ExceptionHandler(error);
    }
}

  Future<List<TypeElement>> getPokemonDetails(String apiUrl)async{
    try{
      final response = await Dio().get(apiUrl);
      return pokemonDetailsFromJson(response.data['types']);
    }catch(error){
      throw ExceptionHandler(error);
    }
  }
}