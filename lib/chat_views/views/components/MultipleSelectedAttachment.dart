import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../models/UserModel.dart';

class MultipleSelectedAttachment extends StatefulWidget {
  final List<File>? attachedFiles;
  final bool isImage;
  final bool isVideo;
  final bool isAudio;
  final UserModel? userModel;
  final bool isStory;

  MultipleSelectedAttachment({this.attachedFiles, this.isImage = false, this.isVideo = false, this.isAudio = false, this.userModel, this.isStory = false});

  @override
  _MultipleSelectedAttachmentState createState() => _MultipleSelectedAttachmentState();
}

class _MultipleSelectedAttachmentState extends State<MultipleSelectedAttachment> {
  PageController controller = PageController(initialPage: 0);
  PageController? videoPageController = PageController(initialPage: 0, keepPage: true);

  int videoIndex = 0;

  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;

  VoidCallback? listener;

  @override
  void initState() {
    super.initState();
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }



  @override
  Widget build(BuildContext context) {
    Widget showWidget() {
      return widget.isImage
          ? PageView.builder(
              // controller: ,
              itemCount: widget.attachedFiles?.length,
              itemBuilder: (_, i) {
                return Container(
                  height: context.height(),
                  width: context.width(),
                  child: Image.file(widget.attachedFiles![i], fit: BoxFit.cover),
                );
              })

                  : SizedBox();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBarWidget("Sent to ${widget.userModel != null ? widget.userModel!.name.validate() : ''}",
              textColor: Colors.black,
              backWidget: Icon(Icons.arrow_back, color: Colors.black).onTap(() {
                finish(context);
              })),
      body: Container(
        height: context.height(),
        child: Stack(
          children: [
            showWidget(),
            Positioned(
              bottom: 50,
              right: 16,
              child: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Icon(Icons.send, color: Colors.white),
              ).onTap(() {
                finish(context, true);
                //              uploadStory();
              }, borderRadius: BorderRadius.circular(50)),
            )
          ],
        ),
      ),
    );
  }

}
