# task_manager_app

A new Flutter project.

## Getting Started

Task Manager App is a Flutter-based mobile application where users can register, log in, and manage their tasks.
The app uses Back4App (Parse Server) for authentication and cloud database storage.
Users can create, edit, delete, and view tasks in a smooth and responsive UI.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Setup & Installation

1. Clone the Repository
   git clone <your-repository-url>
   cd task_manager_app
2. Install Dependencies
   flutter pub get
3. Update Back4App Keys : In lib/services/parse_service.dart >> Replace the placeholders with your Application ID, Client Key, and Server URL from Back4App.
4. Run the App  : flutter run

Make sure a device/emulator is connected.

## App Screenshots
![HomeScreen – No Tasks State.png](ScreenShots%2FHomeScreen%20%96%20No%20Tasks%20State.png)
![HomeScreen (Task List).png](ScreenShots%2FHomeScreen%20%28Task%20List%29.png)
![LoginScreen.png](ScreenShots%2FLoginScreen.png)
![RegisterScreen.png](ScreenShots%2FRegisterScreen.png)
![TaskCreationScreen.png](ScreenShots%2FTaskCreationScreen.png)
![TaskEditingScreen.png](ScreenShots%2FTaskEditingScreen.png)