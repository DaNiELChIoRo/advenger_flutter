import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Character extends Equatable {
  const Character(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnail});

  final int id;
  final String name;
  final String description;
  final CharacterImage thumbnail;

  factory Character.fromJson(Map<String, dynamic> data) {
    print(data['description']);
    return Character(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        thumbnail: CharacterImage.fromJson(data['thumbnail']));
  }

  @override
  List<Object> get props => [id, name, description, thumbnail];
}

class CharacterImage extends Equatable {
  const CharacterImage({required this.path, required this.characterExtension});
  final String path;
  final String characterExtension;

  @override
  List<Object> get props => [path, characterExtension];

  factory CharacterImage.fromJson(Map<String, dynamic> json) {
    return CharacterImage(
        path: json['path'], characterExtension: json['extension']);
  }
}
