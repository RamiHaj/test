import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/app/core/constants/colors.dart';
import 'package:untitled2/app/modules/home/pokemon_details/pokemon_details_model.dart';

class PokemonDetails extends StatelessWidget {
  final TypeElement? typeElement;
  const PokemonDetails({Key? key, required this.typeElement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ConstColors.primaryColor,),
      body: ConditionalBuilder(
          condition: typeElement != null,
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    typeElement!.slot.toString()
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    typeElement!.type!.name ?? ''
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: LinearProgressIndicator(color: ConstColors.primaryColor,))
      ),
    );
  }
}
