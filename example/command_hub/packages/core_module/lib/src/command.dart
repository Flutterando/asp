// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'symbol_icon.dart';

class Command {
  final String name;
  final SymbolIcon icon;
  final String prompt;

  Command({
    required this.icon,
    required this.name,
    required this.prompt,
  });

  @override
  bool operator ==(covariant Command other) {
    if (identical(this, other)) return true;

    return other.name == name && other.icon == icon && other.prompt == prompt;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ prompt.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon.name,
      'prompt': prompt,
    };
  }

  factory Command.fromMap(Map<String, dynamic> map) {
    return Command(
      name: map['name'] as String,
      icon: SymbolIcon.fromString(map['icon'] as String),
      prompt: map['prompt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Command.fromJson(String source) => Command.fromMap(json.decode(source) as Map<String, dynamic>);

  Command copyWith({
    String? name,
    SymbolIcon? icon,
    String? prompt,
  }) {
    return Command(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      prompt: prompt ?? this.prompt,
    );
  }
}
