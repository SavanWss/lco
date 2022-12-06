
import 'package:sqflite/sqflite.dart';

class Db {
  openDb({required num}) async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/myddb.db";

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      try {
        await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');

        print("table is created");
      } catch (e) {
        print("your error === $e");
      }
    });

    switch (num) {
      case 1:
        {
          try {
            await database.transaction((txn) async {
              int id1 = await txn.rawInsert(
                  'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
              print('inserted1: $id1');
              int id2 = await txn.rawInsert(
                  'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
                  ['another name', 12345678, 3.1416]);
              print('inserted2: $id2');
            });
          } catch (e) {
            print("insertion error $e");
          }

          List<Map> list = await database.rawQuery('SELECT * FROM Test');
          // List<Map> expectedList = [
          //   {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
          //   {
          //     'name': 'another name',
          //     'id': 2,
          //     'value': 12345678,
          //     'num': 3.1416
          //   }
          // ];
          print(list);

          int count = await database.rawUpdate(
              'UPDATE Test SET name = ?, value = ? WHERE name = ?',
              ['updated name', '9876', 'some name']);
          print('updated: $count');

          count = await database
              .rawDelete('DELETE FROM Test WHERE name = ? or name = ?', ['another name', "updated name"]);

          List<Map> list1 = await database.rawQuery('SELECT * FROM Test');
      
          print(list1[1]["name"]);

          try {
            await database.close();
            print("database successfully closed");
          } catch (e) {
            print("error is $e");
          }
        }

        break;

      case 2:
        {
          try {
            List<Map> list = await database.rawQuery('SELECT * FROM Test');
            // List<Map> expectedList = [
            //   {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
            //   {
            //     'name': 'another name',
            //     'id': 2,
            //     'value': 12345678,
            //     'num': 3.1416
            //   }
            // ];
            print(list);
            // print(expectedList);
          } catch (e) {
            print("yoour erro $e");
          }
        }
        break;
      default:
    }
  }

  insertQuery() async {}
}
