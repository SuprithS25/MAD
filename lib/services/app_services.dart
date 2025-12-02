// WARNING: This exposes the key in source code. Use only for testing.
import 'package:google_generative_ai/google_generative_ai.dart';

const GEMINI_API_KEY = 'AIzaSyApU3iXzQFgA2n35RRlx0WP9gWBtLi9d5Y';

final model = GenerativeModel(
  model: 'gemini-2.5-flash',
  apiKey: GEMINI_API_KEY,
);