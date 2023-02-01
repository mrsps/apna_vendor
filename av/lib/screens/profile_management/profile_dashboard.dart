import 'dart:io';
import 'package:av/dao/mediaStore.dart';
import 'package:av/models/media/media.dart';
import 'package:av/helpers/randomIdMaker.dart';
import 'package:av/providers/fireAuth.dart';
import 'package:av/screens/profile_management/changePinBottomSheet.dart';
import 'package:av/widgets/mediaPicker.dart';
import 'package:av/screens/profile_management/updateNameBottomSheet.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({Key? key}) : super(key: key);

  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Management',
              style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 3),
            ),
          ],
        ),
        toolbarHeight: 50,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                // Opening display profile selector
                File? file = await showDialog(
                    context: context,
                    builder: (context) {
                      return MediaPicker();
                    });

                if (file != null) {
                  // Getting url of image after uploading it
                  String url = (await MediaStore().uploadImage(file))!;
                  String mediaId = getRandomID('Media');
                  await MediaStore().setMedia(Media(
                      entityId: Provider.of<FireAuth>(context, listen: false).currentUserId,
                      mediaId: mediaId,
                      mediaUrl: url));
                }
              },
              child: StreamBuilder<String?>(
                stream: MediaStore().getUrl(Provider.of<FireAuth>(context).currentUserId),
                builder: (BuildContext context, AsyncSnapshot<String?> url) {
                  if (url.hasError) {
                    throw (url.error!);
                  }
                  if (url.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                      ),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.blue,
                      ),
                    );
                  }
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                        image: url.hasData ? DecorationImage(image: NetworkImage(url.data!)) : null),
                    child: url.hasData ? null : Icon(Icons.person_pin, color: Colors.white, size: 120),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                Provider.of<FireAuth>(context).currentUser.userName!,
                style: TextStyle(fontSize: 30, color: Colors.white, letterSpacing: 3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                // Flow for name update
                String? s = await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => UpdateName(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                );
                if (s != null) showSnack(s, context);
              },
              child: Container(
                height: 40,
                width: 180,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: Text(
                  'Update Name',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                // Flow for change name
                String? s = await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ChangePin(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                );
                if (s != null) showSnack(s, context);
              },
              child: Container(
                height: 40,
                width: 180,
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueGrey)),
                child: Text(
                  'Change Pin',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                border: Border.all(color: Colors.blueGrey),
              ),
              child: IconButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  iconSize: 50,
                  onPressed: () async {
                    showSnack('Logged Out', context);
                    await Provider.of<FireAuth>(context, listen: false).signOut(context);
                  },
                  icon: Icon(Icons.logout)),
            ),
          ],
        ),
      ),
    );
  }
}
