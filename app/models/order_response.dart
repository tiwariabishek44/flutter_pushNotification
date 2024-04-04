class OrderResponse {
  final String id; // Add the id field
  final String classs;
  final String customer;
  final String groupid;
  final String cid;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String groupcod;
  final String checkout;
  final String mealtime;
  final String date; // Store Nepali date as a formatted string
  final String orderType; // Add orderType field
  final String holdDate;
  final String orderTime;
  final String customerImage;

  OrderResponse({
    required this.customerImage,
    required this.id, // Update the constructor to include id
    required this.mealtime,
    required this.classs,
    required this.customer,
    required this.groupid,
    required this.cid,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.groupcod,
    required this.checkout,
    required this.date,
    required this.orderType, // Add orderType to the constructor
    required this.holdDate,
    required this.orderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id, // Add id to the map
      "mealtime": mealtime,
      'classs': classs,
      'customer': customer,
      'groupcod': groupcod,
      'groupid': groupid,
      'cid': cid,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'checkout': checkout,
      'date': date, // Store formatted Nepali date as a string
      'orderType': orderType, // Add orderType to the map
      'holdDate': holdDate,
      'orderTime': orderTime,
      "customerImage": customerImage,
    };
  }

  factory OrderResponse.fromJson(Map<String, dynamic> map) {
    return OrderResponse(
      id: map['id'],
      mealtime:
          map['mealtime'] ?? '', // Provide a default value if mealtime is null
      classs: map['classs'] ?? '', // Provide a default value if classs is null
      customer:
          map['customer'] ?? '', // Provide a default value if customer is null
      groupcod:
          map['groupcod'] ?? '', // Provide a default value if groupcod is null
      groupid:
          map['groupid'] ?? '', // Provide a default value if groupid is null
      cid: map['cid'] ?? '', // Provide a default value if cid is null
      productName: map['productName'] ??
          '', // Provide a default value if productName is null
      productImage: map['productImage'] ??
          '', // Provide a default value if productImage is null
      price: map['price']?.toDouble() ??
          0.0, // Provide a default value if price is null
      quantity:
          map['quantity'] ?? 0, // Provide a default value if quantity is null
      checkout:
          map['checkout'] ?? '', // Provide a default value if checkout is null
      date: map['date'] ?? '', // Provide a default value if date is null
      orderType: map['orderType'] ??
          '', // Provide a default value if orderType is null
      holdDate:
          map['holdDate'] ?? '', // Provide a default value if holdDate is null
      orderTime: map['orderTime'] ?? '',
      customerImage: map['customerImage'] ?? '',
    );
  }
}
