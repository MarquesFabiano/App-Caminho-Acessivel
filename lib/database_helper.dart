import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'favoritos.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favoritos(id INTEGER PRIMARY KEY, nome TEXT, endereco TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertFavorito(Map<String, dynamic> lugar) async {
    final db = await database;
    await db.insert(
      'favoritos',
      lugar,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFavoritos() async {
    final db = await database;
    return await db.query('favoritos');
  }
}
