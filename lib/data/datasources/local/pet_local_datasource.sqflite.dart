import 'package:qpets_app/domain/pet_profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PetLocalDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pet_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE pets (id TEXT PRIMARY KEY, name TEXT, image TEXT, dob TEXT,breed TEXT, type TEXT, gender TEXT, weight TEXT, ownerId TEXT)');
  }

  Future<void> addAllPets(List<PetProfileFields> pets) async {
    final db = await database;
    // aquí se debe llamar al db.insert
    // ignore: avoid_function_literals_in_foreach_calls
    await Future.forEach(pets, (PetProfileFields element) async {
      await db.insert(
        'pets',
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<void> addPet(PetProfileFields product) async {
    final db = await database;
    await db.insert(
      'pets',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PetProfileFields>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> pets = await db.query('pets');
    return List.generate(pets.length, (i) {
      //keep in mind the index
      return PetProfileFields.fromJson(pets[i]);
    });
  }

  Future<PetProfileFields> getPet(String id) async {
    final db = await database;
    List<Map<String, dynamic>> rawPet =
        await db.query("pets", where: "id = ?", whereArgs: [id]);
    return PetProfileFields.fromJson(rawPet[0]);
  }
}
