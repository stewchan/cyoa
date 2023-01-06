import 'dart:convert';

import 'package:cyoa/openai/completions_api.dart';

/// Represents the parameters used in the body of a request to the OpenAI completions endpoint.
class CompletionsRequest {
  final String? model;
  final String prompt;
  final int maxTokens;
  final double? temperature;
  final int? topP;
  final int? n;
  final bool? stream;
  final int? longprobs;
  final String? stop;

  CompletionsRequest({
    required this.prompt,
    required this.maxTokens,
    this.temperature = 0.5,
    this.model,
    this.topP,
    this.n,
    this.stream,
    this.longprobs,
    this.stop,
  });

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'model': model,
      'prompt': prompt,
      'max_tokens': maxTokens,
    };

    if (model != null) {
      jsonBody.addAll({'model': model});
    } else {
      jsonBody.addAll({'model': CompletionsApi.models[1]});
    }

    if (temperature != null) {
      jsonBody.addAll({'temperature': temperature});
    }

    if (topP != null) {
      jsonBody.addAll({'top_p': topP});
    }

    if (n != null) {
      jsonBody.addAll({'n': n});
    }

    if (stream != null) {
      jsonBody.addAll({'stream': stream});
    }

    if (longprobs != null) {
      jsonBody.addAll({'longprobs': longprobs});
    }

    if (stop != null) {
      jsonBody.addAll({'stop': stop});
    }

    return jsonEncode(jsonBody);
  }
}
