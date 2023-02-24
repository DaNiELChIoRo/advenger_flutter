import 'package:bloc/bloc.dart';
import 'package:advengers/bloc/HeroEvent.dart';
import 'package:advengers/bloc/HeroState.dart';
import 'package:advengers/Models/hero_api.dart';
import 'package:advengers/Models/Hero.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  HeroBloc() : super(const HeroState()) {
    on<HeroEvent>((event, emit) => {
          // TODO?
        });
  }

  @override
  Stream<HeroState> mapEventToState(HeroEvent event) async* {
    if (event is HeroFetched) {
      yield await _mapHeroToState(state);
    } else if (event is HeroRefresh) {
      // yield HeroStatus.initial;

      yield await _mapHeroToState(state);
    } else {
      // print('unkown event:', event);
    }
  }

  Future<HeroState> _mapHeroToState(HeroState state) async {
    List<Character> characters;
    try {
      if (state is HeroInitial) {
        characters = await HeroApi.fetchCharacters();
        return HeroLoaded(characters: characters);
      }
      HeroLoaded heroLoaded = state as HeroLoaded;
      characters =
          await HeroApi.fetchCharacters(start: heroLoaded.characters.length);
      return characters.isEmpty
          ? heroLoaded.copyWith(hasReachedMax: true)
          : heroLoaded.copyWith(characters: heroLoaded.characters + characters);
    } catch (e) {
      print(e.toString());
      // return ();
      return HeroError(error: e.toString());
    }
  }
}
