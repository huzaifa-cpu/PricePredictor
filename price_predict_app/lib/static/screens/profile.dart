import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:price_predict_app/dynamic/API/user_repo.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/theme/theme_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/dynamic/firebase/storage_repository.dart';
import 'package:price_predict_app/dynamic/models/user_model.dart';
import 'package:price_predict_app/static/screens/history.dart';
import 'package:price_predict_app/static/screens/loader.dart';
import 'package:price_predict_app/static/utils/theme_preference.dart';
import 'package:price_predict_app/static/widgets/buttons/custom_back_button.dart';
import 'package:price_predict_app/static/widgets/cards/custom_profile_card.dart';
import 'package:price_predict_app/static/widgets/dialogs/custom_dialog.dart';
import 'package:price_predict_app/static/utils/app_themes.dart';
import 'package:price_predict_app/static/widgets/dialogs/custom_edit_dialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  //ANIMATIONS
  Animation animation;
  AnimationController animationController;
  AuthRepository _authRepository = AuthRepository();
  UserRepository userRepository = UserRepository();
  String name;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(GetHistoryEvent());
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  _setTheme(bool darkTheme) async {
    darkOrLight selectedTheme =
        darkTheme ? darkOrLight.lightTheme : darkOrLight.darkTheme;
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeEvent(myTheme: selectedTheme));
    ThemePreferences.saveTheme(selectedTheme);
  }

  String postImageURL;
  File _postImageFile;
  //IMAGE
  Future<void> _getImage(dynamic user) async {
    File imageFileFromGallery =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    BlocProvider.of<UserBloc>(context).add(UserPhotoEvent());

    print(imageFileFromGallery);
    if (imageFileFromGallery != null) {
      setState(() {
        _postImageFile = imageFileFromGallery;
      });
    }
    // store image in firebase
    postImageURL = await Storage.uploadProfileImage(
        uid: user.id, profileImageFile: _postImageFile);
    //save url in database
    UserModel userModel = UserModel(
        email: user.email,
        id: user.id,
        name: user.name,
        photo: postImageURL ?? "no photo");
    BlocProvider.of<UserBloc>(context).add(UserUpdateEvent(userModel));
  }

//----------------------------------------
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topCenter,
                    colors: [theme.primaryColorDark, theme.primaryColor])),
          ),
          SingleChildScrollView(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height / 2,
                      ),
                      Loader(
                        text: '',
                      ),
                      SizedBox(
                        height: height / 2,
                      ),
                    ],
                  );
                } else if (state is UserLoadedState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(),
                          Text("Profile", style: theme.textTheme.headline1),
                          SizedBox(
                            width: width * 0.1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Center(
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: _postImageFile != null
                                    ? FileImage(_postImageFile)
                                    : state.userModel.photo == 'no photo'
                                        ? AssetImage("images/profile.jpg")
                                        : NetworkImage(state.userModel.photo)),
                            Positioned(
                                bottom: 00.0,
                                right: 00.0,
                                child: InkWell(
                                  onTap: () {
                                    _getImage(state.userModel);
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 28.0,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(state.userModel.name,
                          style: theme.textTheme.headline2),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        state.userModel.email,
                        style: theme.textTheme.headline4,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (BuildContext context, Widget child) {
                            return Transform(
                              transform: Matrix4.translationValues(
                                  animation.value * width, 0.0, 0.0),
                              child: Column(
                                children: [
                                  CustomProfileCard(
                                    name: 'Edit name',
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BlocBuilder<UserBloc,
                                                UserState>(
                                              builder: (context, state) {
                                                if (state is UserLoadingState) {
                                                  return Loader(
                                                    text: '',
                                                  );
                                                } else if (state
                                                    is UserLoadedState) {
                                                  return CustomEditDialog(
                                                    initialValue:
                                                        state.userModel.name,
                                                    valueChanged: (val) {
                                                      setState(() {
                                                        name = val;
                                                      });
                                                    },
                                                    onOkPressed: () async {
                                                      User user =
                                                          await _authRepository
                                                              .getCurrentFirebaseUser();
                                                      UserModel userModel =
                                                          UserModel(
                                                              email: user.email,
                                                              id: user.uid,
                                                              name: name ??
                                                                  state
                                                                      .userModel
                                                                      .name,
                                                              photo: state
                                                                  .userModel
                                                                  .photo);
                                                      BlocProvider.of<UserBloc>(
                                                              context)
                                                          .add(UserUpdateEvent(
                                                              userModel));
                                                      Navigator.pop(context);
                                                      return ScaffoldMessenger
                                                              .of(context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content:
                                                              Text('Updated'),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                return Container();
                                              },
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      height: height * 0.09,
                                      width: width * 0.8,
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Change theme",
                                              style: theme.textTheme.headline3,
                                            ),
                                            Spacer(),
                                            Switch(
                                                activeColor: theme.primaryColor,
                                                activeTrackColor:
                                                    Colors.grey.shade200,
                                                inactiveTrackColor:
                                                    Colors.grey.shade200,
                                                value: ThemePreferences
                                                        .getTheme() ==
                                                    darkOrLight.lightTheme,
                                                onChanged: (val) {
                                                  _setTheme(val);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomProfileCard(
                                    name: 'History',
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => History()));
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  CustomProfileCard(
                                    name: 'Logout',
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomDialog(
                                              title: "Logout ?",
                                              onOkPressed: () async {
                                                // ADDING EVENT
                                                await _authRepository.signOut();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  );
                } else if (state is UserFailureState) {
                  return Container();
                }
                return Loader(
                  text: '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
