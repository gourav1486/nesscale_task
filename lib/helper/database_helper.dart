import 'package:flutter/foundation.dart';
import 'package:nesscale_task/models/invoice_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DataBaseHelper {
  static Future<void> createTables(sql.Database database) async {
    final String createInvoicesTableQuery = '''
  CREATE TABLE invoices(
    id INTEGER PRIMARY KEY,
    date TEXT,
    customer TEXT,
    grandTotal REAL
  )
''';
    await database.execute(createInvoicesTableQuery);
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY,
         invoiceId INTEGER,
        name TEXT,
        code TEXT,
        rate REAL,
        FOREIGN KEY (invoiceId) REFERENCES invoices (id)
      )
      """);
    await database.execute("""CREATE TABLE items1(
        id INTEGER PRIMARY KEY,
         invoiceId INTEGER,
        name TEXT,
        code TEXT,
        rate REAL,
        FOREIGN KEY (invoiceId) REFERENCES invoices (id)
      )
      """);

    await database.execute("""CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        customerName TEXT,
        mobileNumber TEXT,
        email TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'nesscale_task.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String name, String? code, double rate) async {
    final db = await DataBaseHelper.db();

    final data = {'name': name, 'code': code, 'rate': rate};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createCustomer(
      String customerName, String? mobileNumber, String email) async {
    final db = await DataBaseHelper.db();

    final data = {
      'customerName': customerName,
      'mobileNumber': mobileNumber,
      'email': email
    };
    final id = await db.insert('customers', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DataBaseHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await DataBaseHelper.db();
    return db.query('customers', orderBy: "id");
  }

  static Future<void> deleteItem(int id) async {
    final db = await DataBaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteCustomers(int id) async {
    final db = await DataBaseHelper.db();
    try {
      await db.delete("customers", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  Future<void> updateItem(Item item) async {
    final db = await DataBaseHelper.db();

    await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );

    await db.close();
  }

  static Future<void> createInvoice(Invoice invoice) async {
    final db = await DataBaseHelper.db();

    await db.transaction((txn) async {
      final invoiceMap = invoice.toMap();
      final invoiceId = await txn.insert('invoices', invoiceMap);

      for (var item in invoice.items) {
        final itemMap = item.toMap();
        itemMap['invoiceId'] = invoiceId;
        await txn.insert('items1', itemMap);
      }
    });

    await db.close();
  }

  static Future<List<Invoice>> getInvoices() async {
    final db = await DataBaseHelper.db();

    final List<Map<String, dynamic>> invoiceMaps = await db.query('invoices');
  
    final List<Invoice> invoices = [];

    for (var invoiceMap in invoiceMaps) {
      final List<Map<String, dynamic>> itemMaps = await db.query('items1',
          where: 'invoiceId = ?', whereArgs: [invoiceMap['id']]);

      final List<Item> items =
          itemMaps.map((itemMap) => Item.fromMap(itemMap)).toList();

      final invoice = Invoice.fromMap(invoiceMap, items);
      invoice.items = items;

      invoices.add(invoice);
    }

    await db.close();

    return invoices;
  }
}
