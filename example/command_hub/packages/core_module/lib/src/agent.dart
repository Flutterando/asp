import 'dart:io';

class Agent {
  final String name;
  final String description;
  final List<Input> inputs;
  final Map<String, String> platformCommands;

  Agent({
    required this.name,
    required this.description,
    required this.inputs,
    required this.platformCommands,
  });

  factory Agent.fromYaml(Map<String, dynamic> yaml) {
    var inputs = (yaml['inputs'] as List).map((input) => Input.fromYaml(input)).toList();

    var platform = (yaml['platform'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(key, value['execute'] as String),
    );

    return Agent(
      name: yaml['name'],
      description: yaml['description'],
      inputs: inputs,
      platformCommands: platform,
    );
  }

  Future<String> execute(Map<String, dynamic> vars) async {
    var platform = Platform.operatingSystem;
    var commandTemplate = platformCommands[platform] ?? platformCommands['all'];

    if (commandTemplate != null) {
      var finalCommand = commandTemplate;
      for (var entry in vars.entries) {
        final key = entry.key;
        final value = entry.value;
        finalCommand = finalCommand.replaceAll('\${$key}', value.toString());
      }

      // Seleciona o shell apropriado para a plataforma
      List<String> shellCommand;
      if (platform == 'windows') {
        shellCommand = ['powershell', '-Command', finalCommand];
      } else {
        shellCommand = ['bash', '-c', finalCommand];
      }

      // Executa o comando usando Process.run e retorna stdout ou stderr
      try {
        var result = await Process.run(shellCommand.first, shellCommand.sublist(1));
        return _processResult(result);
      } catch (e) {
        return 'Erro ao executar o comando: $e';
      }
    } else {
      return 'Nenhum template de comando encontrado para a plataforma: $platform';
    }
  }

  String _processResult(ProcessResult result) {
    if (result.exitCode == 0) {
      return result.stdout is String ? result.stdout : String.fromCharCodes(result.stdout);
    } else {
      return result.stderr is String ? result.stderr : String.fromCharCodes(result.stderr);
    }
  }
}

class Input {
  final String name;
  final String description;
  final String type;
  dynamic _value;

  dynamic get value => _value;
  void setValue(dynamic value) {
    _value = value;
  }

  Input({
    required this.name,
    required this.description,
    required this.type,
  });

  factory Input.fromYaml(Map<String, dynamic> yaml) {
    return Input(
      name: yaml['name'],
      description: yaml['description'],
      type: yaml['type'],
    );
  }
}
