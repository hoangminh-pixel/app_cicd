import 'dart:developer';
import 'dart:io';

import 'package:bt_management_flutter/core/configs/di.dart';
import 'package:bt_management_flutter/core/configs/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

class MapLauncherDemo extends StatefulWidget {
  const MapLauncherDemo({super.key});

  @override
  State<MapLauncherDemo> createState() => _MapLauncherDemoState();
}

class _MapLauncherDemoState extends State<MapLauncherDemo> {
  String tokenApp = '';
  String? imagePath;

  openMapsSheet(context) async {
    try {
      final coords = Coords(20.998051, 105.825330);
      final title = "Benh vien";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showDirections(
                          // coords: coords,
                          // title: title,
                          destination: coords,
                        ),
                        title: Text(map.mapName),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handlePushNotificationsToken();
  }

  /// Retrieves and manages the FCM token for push notifications
  Future<void> _handlePushNotificationsToken() async {
    // Get the FCM token for the device
    final token = await FirebaseMessaging.instance.getToken();
    setState(() {
      tokenApp = token ?? '';
    });
    print('$token');

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print('FCM token refreshed: $fcmToken');
      setState(() {
        tokenApp = fcmToken;
      });
      // TODO: optionally send token to your server for targeting this device
    }).onError((error) {
      // Handle errors during token refresh
      print('Error refreshing FCM token: $error');
    });
  }

  bool isShowingDialog = false;

  void showNoInternetDialog() {
    if (isShowingDialog) return;

    isShowingDialog = true;

    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Mất kết nối'),
      ),
    ).then((_) {
      isShowingDialog = false;
    });
  }

  Future<void> uploadImage() async {
    final dioCilent = getIt<DioClient>().dio;
    try {
      final formData = FormData.fromMap({
        'login': 'admin',
        'password': 'admin@123VN',
        'image':
            await MultipartFile.fromFile(imagePath ?? '', filename: 'image.jpg')
      });
      final response = await dioCilent.post(
        'test_file',
        data: formData,
      );
      log('response ${response.data}');
    } on DioException  catch (e) {
      if(e.type == DioExceptionType.connectionError){
        showNoInternetDialog();
      }
      log('error uploadImage() $e');
    }
  }

  void pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imagePath = image?.path ?? '';
      });
      await uploadImage();
      await uploadImage();
    } catch (e) {
      log('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Launcher Demo'),
      ),
      body: Center(child: Builder(
        builder: (context) {
          return Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(File(imagePath ?? '')),
              ),
              MaterialButton(
                onPressed: () => openMapsSheet(context),
                child: const Text('Show Maps'),
              ),
              TextFormField(
                // initialValue: tokenApp,
                controller: TextEditingController(text: tokenApp),
              ),
              MaterialButton(
                onPressed: pickImage,
                child: const Text('Pick Image'),
              ),
              // SelectableText(
              //   tokenApp,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // )
            ],
          );
        },
      )),
    );
  }
}
