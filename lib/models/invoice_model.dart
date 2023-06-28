class Item {
  final String name;
  final double rate;
  final String code;
  int id;

  Item({required this.name, required this.rate, required this.code,required this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'rate': rate, 'code': code};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(name: map['name'], rate: map['rate'], code: map['code'], id:map['id']);
  }
}

class Invoice {
  final String date;
  final String customer;
  List<Item> items;
  final double grandTotal;

  Invoice({
    required this.date,
    required this.customer,
    required this.items,
    required this.grandTotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'customer': customer,
      'grandTotal': grandTotal,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map, List<Item> items) {
    return Invoice(
      date: map['date'],
      customer: map['customer'],
      items: items,
      grandTotal: map['grandTotal'],
    );
  }
}
