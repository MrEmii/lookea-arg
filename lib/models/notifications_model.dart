class NotificationsModel{

  String id;
  String title;
  String description;
  Map<String, dynamic> information;
  /*
   * {
   *  "push": "/pushTo",
   *  "modek": {}
   * }
  */

  NotificationsModel({this.title, this.description, this.information, this.id});

  factory NotificationsModel.fromJson(Map<String, dynamic> obj) => NotificationsModel(
    title: obj["title"],
    description: obj["description"],
    information: obj["information"],
    id: obj["id"]
  );

  toJson() => <String, dynamic>{
    "title": title,
    "description": description,
    "information": information,
    "id": id
  };

}