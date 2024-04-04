class TransctionResponse {
  String? productId;
  String? productName;
  String? totalAmount;
  String? code;
  Message? message;
  TransactionDetails? transactionDetails;
  String? merchantName;

  TransctionResponse({
    this.productId,
    this.productName,
    this.totalAmount,
    this.code,
    this.message,
    this.transactionDetails,
    this.merchantName,
  });

  factory TransctionResponse.fromJson(Map<String, dynamic> json) =>
      TransctionResponse(
        productId: json["productId"],
        productName: json["productName"],
        totalAmount: json["totalAmount"],
        code: json["code"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        transactionDetails: json["transactionDetails"] == null
            ? null
            : TransactionDetails.fromJson(json["transactionDetails"]),
        merchantName: json["merchantName"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "totalAmount": totalAmount,
        "code": code,
        "message": message?.toJson(),
        "transactionDetails": transactionDetails?.toJson(),
        "merchantName": merchantName,
      };
}

class Message {
  String? technicalSuccessMessage;
  String? successMessage;

  Message({
    this.technicalSuccessMessage,
    this.successMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        technicalSuccessMessage: json["technicalSuccessMessage"],
        successMessage: json["successMessage"],
      );

  Map<String, dynamic> toJson() => {
        "technicalSuccessMessage": technicalSuccessMessage,
        "successMessage": successMessage,
      };
}

class TransactionDetails {
  String? date;
  String? referenceId;
  String? status;

  TransactionDetails({
    this.date,
    this.referenceId,
    this.status,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        date: json["date"],
        referenceId: json["referenceId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "referenceId": referenceId,
        "status": status,
      };
}
