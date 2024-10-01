import 'package:educately_chat/modules/messaging/models/conv_message_model.dart';

const img1 =
    "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
const img2 =
    "https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg";

final testMsgs = [
  ConvMessageModel(
    text: "Hello",
    username: "John1",
    userId: "1",
    time: DateTime.now(),
    profilePic: img1,
    isSent: true,
  ),
  ConvMessageModel(
    text: "Hello",
    username: "John2",
    userId: "2",
    time: DateTime.now(),
    profilePic: img2,
    isSent: false,
  ),
  ConvMessageModel(
    text: "Hello",
    username: "John2",
    userId: "2",
    time: DateTime.now(),
    profilePic: img2,
    isSent: false,
  ),
  ConvMessageModel(
    text: "Hello",
    username: "John2",
    userId: "2",
    time: DateTime.now(),
    profilePic: img2,
    isSent: false,
  ),
  ConvMessageModel(
    text: "Hello",
    username: "John2",
    userId: "2",
    time: DateTime.now(),
    profilePic: img2,
    isSent: false,
  ),
];
