import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:firebase_core/firebase_core.dart';

class NotificationController {
  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    await Firebase.initializeApp();

    // if (action.buttonKeyPressed.isNotEmpty &&
    //     action.buttonKeyPressed == 'REPLY') {
    //   final replyText = action.buttonKeyInput;
    //   final receiverId = action.payload?['accountId'];
    //   final senderId = FirebaseAuth.instance.currentUser?.uid;

    //   if (replyText.isNotEmpty && receiverId != null && senderId != null) {
    //     final users = [senderId, receiverId]..sort();
    //     final chatRoomId = users.join("_");

    //     final batch = FirebaseFirestore.instance.batch();

    //     final chatroom = FirebaseFirestore.instance.collection("user");

    //     final messageRef = chatroom.doc(chatRoomId).collection('messages');

    //     final messageDoc = messageRef.doc();

    //     //add message to sub collection
    //     batch.set(messageDoc, message.toMap());

    //     //update chatroom

    //     batch.update(chatroom.doc(chatRoomId), {
    //       "lastMessage": replyText,
    //       "lastMessageSenderId": senderId,
    //       "lastMessageTime": message.timestamp,
    //     });
    //     await batch.commit();
    //   }
    // } else {
    //   final data = action.payload ?? {};
    //   NotificationHandler.handleTapNavigate(data, NotificationsService.entity);
    // }
  }
}
