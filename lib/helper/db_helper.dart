import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'stackit.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            tags TEXT,
            likes INTEGER,
            answers INTEGER,
            timeAgo TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE answers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question_id INTEGER,
            text TEXT,
            timeAgo TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS answers (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              question_id INTEGER,
              text TEXT,
              timeAgo TEXT
            )
          ''');
        }
      },
    );
  }

  static Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  // Insert a new question into the database
  static Future<void> insertQuestion(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('questions', data);
  }

  // Get all questions
  static Future<List<Map<String, dynamic>>> getQuestions() async {
    final db = await database;
    return db.query('questions', orderBy: 'id DESC');
  }

  // Delete a question
  static Future<void> deleteQuestion(int id) async {
    final db = await database;
    await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }

  // Insert a new answer for a question
  static Future<void> insertAnswer(int questionId, String text) async {
    final db = await database;
    await db.insert('answers', {
      'question_id': questionId,
      'text': text,
      'timeAgo': DateTime.now().toIso8601String(),
    });

    // Increment answer count in the related question
    await db.rawUpdate(
      'UPDATE questions SET answers = answers + 1 WHERE id = ?',
      [questionId],
    );
  }

  // Get all answers for a specific question
  static Future<List<Map<String, dynamic>>> getAnswers(int questionId) async {
    final db = await database;
    return db.query(
      'answers',
      where: 'question_id = ?',
      whereArgs: [questionId],
      orderBy: 'id DESC',
    );
  }

  // Increment the like count of a question
  static Future<void> incrementLike(int questionId) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE questions SET likes = likes + 1 WHERE id = ?',
      [questionId],
    );
  }
}
