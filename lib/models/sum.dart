class SumModel {

    int num;

    SumModel({
        required this.num
    });

    factory SumModel.fromJson(Map<String, dynamic> json) {
        return SumModel(
            num: json['num'],
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "num": num,
        };
    }

}