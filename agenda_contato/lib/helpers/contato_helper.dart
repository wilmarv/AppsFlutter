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
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable ($idColoumn INTEGER PRIMARY KEY, $nomeColoumn TEXT, $emailColoumn TEXT,"
          "$telColoumn TEXT, $imgColoumn TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contato)async{
    Database dbContact = await db;
    contato.id =await dbContact.insert(contactTable, contato.toMap());
    return contato;
  }

  Future<Contact> getContact(int id)async{
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
    columns: [idColoumn,nomeColoumn,emailColoumn,telColoumn,idColoumn],
    where: "$idColoumn = ?",
    whereArgs: [id]);
    if(maps.length >0)
      return Contact.fromMap(maps.first);
    else
      return null;
  }
  Future<int>deleteContact(int id)async{
    Database dbContatc = await db;
    return await dbContatc.delete(contactTable,where: "$idColoumn = ?",whereArgs: [id]);
  }
  Future<int>updateContact(Contact contato)async{
    Database dbContatc = await db;
    return await dbContatc.update(contactTable, contato.toMap(),where: "$idColoumn = ? ",whereArgs: [contato.id]);
  }
  Future<List> getall()async{
    Database dbContatc = await db;
    List listMap = await dbContatc.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContato = List();
    for(Map m in listMap){
      listContato.add(Contact.fromMap(m));
    }
    return listContato;
  }
  Future<int> getNumber()async{
    Database dbContatc = await db;
    return Sqflite.firstIntValue(await dbContatc.rawQuery("SELECT COUTN(*) FROM $contactTable"));
  }
  Future close() async{
    Database dbContatc = await db;
    dbContatc.close();
  }
}


class Contact {
  int id;
  String nome;
  String email;
  String tel;
  String img;

  Contact();

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
