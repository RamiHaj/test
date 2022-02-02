import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled2/app/core/exceptions/exceptions.dart';
import 'package:untitled2/app/core/services/toast.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_model.dart';
import 'package:untitled2/app/modules/home/pokemon_details/pokemon_details_model.dart';
import 'package:untitled2/app/modules/home/shared/home_repository.dart';
import 'package:untitled2/app/modules/home/shared/status.dart';

class PokemonController extends Cubit<PokemonStatus>{

  PokemonController() : super(PokemonInitialState());

  static PokemonController get(context) => BlocProvider.of(context);

  final RefreshController refreshController = RefreshController(initialRefresh: true);


  List<Result> pokemonModel = [];
  List<Result> temp = [];
  int limitTemp = 20;
  bool loading = false;
  ScrollController scrollController = ScrollController();


  void getPokemons(int limitAfter)async{
    emit(LoadingPokemonState());
    int limit = limitTemp + limitAfter;
    loading = true;
    try{
      await Future.delayed(const Duration(milliseconds: 500));
      temp = pokemonModel.length >= 100 ? [] : await HomeRepository().getPokemon(limit);
      limitTemp = limit ;
      if(temp.isNotEmpty){
        pokemonModel.clear();
        pokemonModel.addAll(temp);
      }
      loading = false;
      emit(SuccessPokemonState());
    }on CustomException catch (e){
      emit(ErrorPokemonState());
      CustomToast.showError(e.error);
    }
  }

  List<TypeElement> pokemonDetailsModel = [];

  Future<List<TypeElement>?> getPokemonDetails(String apiUrl)async{
    emit(LoadingPokemonState());
    try{
      pokemonDetailsModel = await HomeRepository().getPokemonDetails(apiUrl);
      emit(SuccessPokemonState());
      return pokemonDetailsModel;
    }on CustomException catch (e){
      emit(ErrorPokemonState());
      CustomToast.showError(e.error);
    }
  }

}