import 'package:core_module/core_module.dart';

class Pipeline {
  final String title;
  final bool favorite;
  final String description;
  final List<Agent> agents;

  Pipeline({
    required this.title,
    required this.favorite,
    required this.description,
    required this.agents,
  });

  Pipeline copyWith({
    String? title,
    String? description,
    List<Agent>? agents,
    bool? favorite,
  }) {
    return Pipeline(
      title: title ?? this.title,
      description: description ?? this.description,
      agents: agents ?? this.agents,
      favorite: favorite ?? this.favorite,
    );
  }
}
