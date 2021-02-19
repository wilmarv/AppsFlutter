import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";
final String idColoumn = "idColumn";
final String nomeColoumn = "nameColumn";
final String emailColoumn = "emailColumn";
final String telColoumn = "telColumn";
final String imgColoumn = "imgColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database>get db async{
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColoumn INTERGER PRIMARY KEY, $nomeColoumn TEXT, $emailColoumn TEXT"
          "$telColoumn TEXT, $imgColoumn TEXT)");
    });
  }
}

class Contact {
  int id;
  String nome;
  String email;
  String tel;
  String img;

  Contact.fromMap(Map map) {
    id = map[idColoumn];
    nome = map[nomeColoumn];
    email = map[emailColoumn];
    tel = map[telColoumn];
    img = map[imgColoumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeColoumn: nome,
      emailColoumn: email,
      telColoumn: tel,
      imgColoumn: img
    };
    if (id != null) {
      map[idColoumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, nome: $nome, email: $email, telefone: $tel img: $img)";
  }
}
