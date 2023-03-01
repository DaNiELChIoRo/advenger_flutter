import 'package:bloc/bloc.dart';
import 'package:advengers/bloc/HeroEvent.dart';
import 'package:advengers/bloc/HeroState.dart';
import 'package:advengers/Models/hero_api.dart';
import 'package:advengers/Models/Hero.dart';
import 'package:flutter/cupertino.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  HeroBloc() : super(const HeroState()) {
    on<HeroFetched>((event, emit) async {
      List<Character> characters;
      // HeroLoaded heroLoaded = state as HeroLoaded;
      characters = await HeroApi.fetchCharacters(start: 0);
      emit(HeroLoaded(characters: characters));
    });

    on<HeroRefresh>((event, emit) {});
  }

  Future<HeroState> _mapHeroToState(HeroState state) async {
    List<Character> characters;
    try {
      if (state is HeroInitial) {
        characters = await HeroApi.fetchCharacters();
        return HeroLoaded(characters: characters);
      }
      if (state is HeroFetched) {
        HeroLoaded heroLoaded = state as HeroLoaded;
        characters =
            await HeroApi.fetchCharacters(start: heroLoaded.characters.length);
        return characters.isEmpty
            ? heroLoaded.copyWith(hasReachedMax: true)
            : heroLoaded.copyWith(
                characters: heroLoaded.characters + characters);
      }
      if (state is HeroLoaded) {
        HeroLoaded heroLoaded = state as HeroLoaded;
        characters =
            await HeroApi.fetchCharacters(start: heroLoaded.characters.length);
        return characters.isEmpty
            ? heroLoaded.copyWith(hasReachedMax: true)
            : heroLoaded.copyWith(
                characters: heroLoaded.characters + characters);
      }
      if (state is HeroError) {
        print(state);
        return HeroError(error: "unkown state");
      } else {
        print(state);
        return HeroError(error: "unkown state");
      }
    } catch (e) {
      print(e.toString());
      return HeroError(error: e.toString());
    }
  }
}
