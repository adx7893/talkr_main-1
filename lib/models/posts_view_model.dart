import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talkr_demo/main.dart';
import 'package:talkr_demo/screens/post_screen.dart';

class PostsViewModel extends ChangeNotifier {
  //Services
  UserService userService = UserService();
  PostService postService = PostService();

  //Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Variables
  bool loading = false;
  late String username;
  late File mediaUrl;
  final picker = ImagePicker();
  late String location;
  late Position position;
  late Placemark placemark;
  late String bio;
  late String description;
  late String email;
  late String commentData;
  late String ownerId;
  late String userId;
  late String type;
  late File userDp;
  late String imgLink;
  bool edit = false;
  late String id;

  //controllers
  TextEditingController locationTEC = TextEditingController();

  get Geolocator => null;

  //Setters
  setEdit(bool val) {
    edit = val;
    notifyListeners();
  }

  setPost(PostModel post) {
    if (post != null) {
      description = post.description;
      imgLink = post.mediaUrl;
      location = post.location;
      edit = true;
      edit = false;
      notifyListeners();
    } else {
      edit = false;
      notifyListeners();
    }
  }

  setUsername(String val) {
    print('SetName $val');
    username = val;
    notifyListeners();
  }

  setDescription(String val) {
    print('SetDescription $val');
    description = val;
    notifyListeners();
  }

  setLocation(String val) {
    print('SetCountry $val');
    location = val;
    notifyListeners();
  }

  setBio(String val) {
    print('SetBio $val');
    bio = val;
    notifyListeners();
  }

  //Functions
  pickImage({bool camera = false, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    try {
      PickedFile? pickedFile = await picker.getImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      var Constants;
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Constants.lightAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      mediaUrl = File(croppedFile.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      showInSnackBar('Cancelled', context);
    }
  }

  getLocation() async {
    loading = true;
    notifyListeners();
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission rPermission = await Geolocator.requestPermission();
      print(rPermission);
      await getLocation();
    } else {
      var LocationAccuracy;
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      placemark = placemarks[0];
      location = " ${placemarks[0].locality}, ${placemarks[0].country}";
      locationTEC.text = location;
      print(location);
    }
    loading = false;
    notifyListeners();
  }

  uploadPosts(BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      await postService.uploadPost(mediaUrl, location, description);
      loading = false;
      resetPost();
      notifyListeners();
    } catch (e) {
      print(e);
      loading = false;
      resetPost();
      showInSnackBar('Uploaded successfully!', context);
      notifyListeners();
    }
  }

  uploadProfilePicture(BuildContext context) async {
    if (mediaUrl == null) {
      showInSnackBar('Please select an image', context);
    } else {
      try {
        loading = true;
        notifyListeners();
        var firebaseAuth;
        await postService.uploadProfilePicture(
            mediaUrl, firebaseAuth.currentUser);
        loading = false;
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (_) => PostScreen()));
        notifyListeners();
      } catch (e) {
        print(e);
        loading = false;
        showInSnackBar('Uploaded successfully!', context);
        notifyListeners();
      }
    }
  }

  resetPost() {
    mediaUrl = mediaUrl;
    description = description;
    location = location;
    edit = edit;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  AndroidUiSettings(
      {required String toolbarTitle,
      toolbarColor,
      required Color toolbarWidgetColor,
      initAspectRatio,
      required bool lockAspectRatio}) {}

  IOSUiSettings({required double minimumAspectRatio}) {}

  placemarkFromCoordinates(latitude, longitude) {}
}

class LocationPermission {
  static var denied;
  static var deniedForever;
}

class UserService {}

class CropAspectRatioPreset {
  static var square;

  static var ratio3x2;

  static var original;

  static var ratio4x3;

  static var ratio16x9;
}

class ImageCropper {
  static cropImage(
      {required String sourcePath,
      required List aspectRatioPresets,
      androidUiSettings,
      iosUiSettings}) {}
}

class PostModel {
  late String description;

  late String mediaUrl;

  late String location;
}

class Placemark {
  var locality;

  var country;
}

class Position {
  get latitude => null;

  get longitude => null;
}

class PostService {
  uploadProfilePicture(File mediaUrl, currentUser) {}

  uploadPost(File mediaUrl, String location, String description) {}
}
