import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/app/core/constants/colors.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_controller.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_model.dart';
import 'package:untitled2/app/modules/home/pokemon_details/pokemon_details_view.dart';
import 'package:untitled2/app/modules/home/shared/status.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonController, PokemonStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        PokemonController pokemonController = PokemonController.get(context);
        pokemonController.scrollController.addListener(() {
          if (pokemonController.scrollController.position.pixels >=
                  pokemonController.scrollController.position.maxScrollExtent &&
              !pokemonController.loading) {
            pokemonController.getPokemons(20);
          }
        });
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ConstColors.primaryColor,
          ),
          body: ConditionalBuilder(
              condition: pokemonController.pokemonModel.isNotEmpty,
              builder: (context) => Stack(
                    children: [
                      ListView.separated(
                        controller: pokemonController.scrollController,
                        itemBuilder: (context, index) => buildPokemon(
                            pokemonController.pokemonModel[index],
                            pokemonController,
                            context),
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                        ),
                        itemCount: pokemonController.pokemonModel.length,
                      ),
                      if (pokemonController.loading)
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: ConstColors.primaryColor,
                            ))),
                    ],
                  ),
              fallback: (context) => Center(
                      child: CircularProgressIndicator(
                    color: ConstColors.primaryColor,
                  ))),
        );
      },
    );
  }

  Widget buildPokemon(Result result, PokemonController pokemonController,
      BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await pokemonController.getPokemonDetails(result.url!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonDetails(
                      typeElement: pokemonController.pokemonDetailsModel.first,
                    )));
      },
      child: ListTile(
        title: Text(result.name ?? ''),
      ),
    );
  }
}
