class ChatRoomModel {
  String? chatRoomID;
  List<String>?particiapants;

  ChatRoomModel({this.chatRoomID,this.particiapants});

  ChatRoomModel.fromMap(Map<String,dynamic> map){
    chatRoomID =map["chatRoomID"];
    particiapants = map["participants"];
  }
  Map<String,dynamic>toMap(){
    return{
      "chatRoomID":chatRoomID,
      'participants':particiapants,
    };
  }
}