import 'package:equatable/equatable.dart';
import 'package:advengers/Models/Hero.dart';

// enum HeroStatus { initial, success, failture(String) }

class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object> get props => [];
}

class HeroInitial extends HeroState {}

class HeroError extends HeroState {
  const HeroError({required this.error});

  final String error;
}

class HeroLoaded extends HeroState {
  final List<Character> characters;
  final bool hasReachedMax;

  const HeroLoaded(
      {this.characters = const <Character>[], this.hasReachedMax = false});

  HeroLoaded copyWith({List<Character>? characters, bool? hasReachedMax}) {
    return HeroLoaded(
        characters: characters ?? this.characters,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [characters, hasReachedMax];
}
