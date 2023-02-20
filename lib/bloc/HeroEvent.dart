import 'package:advengers/Models/Hero.dart';
import 'package:equatable/equatable.dart';

abstract class HeroEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HeroRefresh extends HeroEvent {}

class HeroFetched extends HeroEvent {}
