import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled2/app/core/dio/dio_factory.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_controller.dart';
import 'package:untitled2/app/modules/home/pokemon/pokemon_view.dart';
import 'package:untitled2/app/modules/home/shared/status.dart';

import 'bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonController()..getPokemons(0),
      child: BlocConsumer<PokemonController , PokemonStatus>(
        listener: (context , state){},
        builder: (context , state){
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: ()=> const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: PokemonView(),
            ),
          );
        },
      ),
    );
  }
}

