class OrderModel {

    String subject;
    int total;
    bool success;

    OrderModel({
        required this.subject,
        required this.total,
        required this.success
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) {
        return OrderModel(
            subject: json['subject'],
            total: json['total'],
            success: json['success']
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "subject": subject,
            "total": total,
            "success": success
        };
    }
}