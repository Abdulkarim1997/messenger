import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/layout/social_app/cubit/states.dart';
import 'package:messenger/models/social_app/post_model.dart';
import 'package:messenger/modules/social_app/chats/chats_screen.dart';
import 'package:messenger/modules/social_app/feeds/feeds_screen.dart';

import '../../../models/social_app/message_model.dart';
import '../../../models/social_app/social_user_model.dart';
import '../../../modules/social_app/new_post/new_post_screen.dart';
import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import '../../../shard/components/constants.dart';

class SocailCubit extends Cubit<SocialStates> {
  SocailCubit() : super(SocialInitialState());
  static SocailCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print("sss" + value.data().toString());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(SocialProfileImagePickerSuccessState());
    } else {
      print("No image selected");
      emit(SocialProfileImagePickerErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(SocialCoverImagePickerSuccessState());
    } else {
      print("No image selected");
      emit(SocialCoverImagePickerErrorState());
    }
  }

  File? postImage;
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> getpostImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(SocialPostImagePickerSuccessState());
    } else {
      print("No image selected");
      emit(SocialPostImagePickerErrorState());
    }
  }

  void uploadProfileImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("DownloadURLprofileImage" + value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
        // emit(SocialUploadProfileImageSuccessState());

        // ignore: argument_type_not_assignable_to_error_handler
      }).catchError(() {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((Error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required name,
    required phone,
    required bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print("DownloadURLCoverImage" + value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);

        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((Error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required name,
  //   required phone,
  //   required bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required name,
    required phone,
    required bio,
    String? image,
    String? cover,
  }) {
    print(userModel?.email.toString());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: userModel?.email,
      uId: uId,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      isEmailVerified: false,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(postImage: value, dateTime: dateTime, text: text);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((Error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      dateTime: dateTime,
      text: text,
      image: userModel?.image,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          comments.add(value.docs.length);
          // print(element.id);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    // if you do not want to get each entry to chat use if(users.length == 0)
    users.clear();
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["uId"] != userModel?.uId) {
          users.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId.toString())
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commentPost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId.toString())
        .set({
      'comment': comment,
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void sendMessage({
    @required reciverId,
    @required dateTime,
    @required text,
  }) {
    messages.clear();
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      reciverId: reciverId,
      senderId: userModel?.uId,
    );
    // set my chats
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel?.uId)
        .collection("chats")
        .doc(reciverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    // set reciver chats
    FirebaseFirestore.instance
        .collection("users")
        .doc(reciverId)
        .collection("chats")
        .doc(userModel?.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    @required reciverId,
  }) {
    messages.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId.toString())
        .collection('chats')
        .doc(reciverId.toString())
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        print("lllss" + element.data().toString());
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  List<String> titles = [
    'Home',
    'Chats',
    'add post',
    'Users',
    'Settings',
  ];
}
