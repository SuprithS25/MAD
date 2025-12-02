// lib/services/app_services.dart

// =============================
// 1. CONSOLIDATE ALL IMPORTS AT THE TOP
// =============================
// Imports for GEMINI AI
import 'package:google_generative_ai/google_generative_ai.dart';

// Imports for DRIFT DATABASE
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart'; 

// =============================
// 2. PLACE ALL DECLARATIONS AFTER IMPORTS
// =============================

// 🌐 GEMINI AI INTEGRATION
// Replace this with your actual key-loading method (e.g., from .env)
const GEMINI_API_KEY = 'YOUR_LOADED_API_KEY';

final model = GenerativeModel(
  model: 'gemini-2.5-flash',
  apiKey: GEMINI_API_KEY,
);

/// Generates a text response using Gemini API
Future<String> getGeminiResponse(String prompt) async {
  try {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No response generated.';
  } catch (e) {
    print('Gemini API Error: $e');
    return 'Error: Could not connect to AI ($e)';
  }
}

// 🗄️ DRIFT DATABASE CONNECTION
/// Opens the database connection using a LazyDatabase.
/// Handles Android SQLite compatibility issues.
LazyDatabase openExecutor() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web support is not yet implemented for Drift. '
        'Consider using drift_web for browser support.',
      );
    }

    if (Platform.isAndroid) {
      // Workaround for older Android versions
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase.createInBackground(file);
  });
}