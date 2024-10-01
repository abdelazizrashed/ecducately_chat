# Educatly Chat

A Real-Time Chat Interface with Firebase Integration, Online Status, and Typing Indicators (Android Only) Using a Basic Dark Theme (Figma design file).
This Project is the Task for Senior Flutter Developer @ Educatly

## Running The project

* Flutter Version => 3.24.3


1- Clone Project

```
git clone https://github.com/abdelazizrashed/ecducately_chat.git
cd educately_chat
```
2- Setup Firebase project
* Create Firebase Project
* Setup Firebase Authentication with email authentication
* Create a Firestore database

3- Connecting Firebase with the project
* Install [Firestore CLI](https://firebase.google.com/docs/cli?hl=en&authuser=2#install_the_firebase_cli)
* run ```firebase login```
* From any directory, run this command:

```
dart pub global activate flutterfire_cli
```
* Then, at the root of your Flutter project directory, run this command:
  
  replace \<your-project-id\> with your project id

```
flutterfire configure --project=<your-project-id>
```

4- Run the application
```
flutter run
```
