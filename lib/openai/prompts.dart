class Prompts {
  static String createPrompt(String phrase) {
    String prompt = "Suggest three names for an $phrase that is a superhero.";
    return prompt;
  }

  static String inventory() {
    String prompt = "What is currently in my adventure inventory?";
    return prompt;
  }

  static String begin() {
    String prompt =
        "Give me the first paragraph of an exciting adventure to go on for my next choose your own adventure story.";
    return prompt;
  }
}
