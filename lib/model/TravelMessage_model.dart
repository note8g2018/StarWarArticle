class TravelMessage
{
  String description;
  bool result;

  TravelMessage({this.result, this.description});

  factory TravelMessage.fromJson(dynamic jsonObj)
  {
    return TravelMessage(
        description: jsonObj["description"] as String,
        result: jsonObj["result"] as bool,
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "description": description,
      "result": result,
    };
  }
}