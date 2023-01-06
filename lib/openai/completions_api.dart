import 'dart:math';

import 'package:cyoa/openai/completions_request.dart';
import 'package:cyoa/openai/completions_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class CompletionsApi {
  static const models = [
    'text-ada-001',
    'text-babbage-001',
    'text-curie-001',
    'text-davinci-003',
  ];

  // The OpenAI API key
  static const String openaiApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );

  // The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  // The headers for the completions endpoint, which are the same for all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openaiApiKey',
  };

  static Future<CompletionsResponse> fetchCompletion({
    required String prompt,
    int maxTokens = 20,
  }) async {
    CompletionsRequest request = CompletionsRequest(
      prompt: prompt,
      maxTokens: maxTokens,
    );

    http.Response response = await http.post(
      completionsEndpoint,
      headers: headers,
      body: request.toJson(),
    );

    debugPrint('Received OpenAI API response: ${response.body}');
    // Check to see if there was an error
    if (response.statusCode != 200) {
      debugPrint(
          'Failed to get a completion with status code, ${response.statusCode}');
    }

    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    return completionsResponse;
  }
}
