class TaskModel {
  String id;
  String userId;


  TaskModel({
    this.id = "",
    required this.userId,

  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          userId: json['userId'],

        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,

    };
  }
}
