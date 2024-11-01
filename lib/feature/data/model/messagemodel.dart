class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? creation;
MessageModel({this.text,this.creation,this.messageId,this.seen,this.sender});
MessageModel.fromMap(Map<String, dynamic>map){
  messageId = map["message_id"];
  sender = map["sender"];
  text = map["text"];
  seen = map["seen"];
  creation = map["creation"].toDate();
}
Map<String,dynamic>roMap(){
  return{
    'messageid':messageId,
    'sender':sender,
    'text':text,
    'seen':seen,
    'creation':creation
  };
}
}