import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageWidget extends StatefulWidget {
  final String? photoUrl;
  final String? name;
  final bool isFromChat;
  final bool isVideo;

  FullScreenImageWidget({this.photoUrl, this.name, this.isFromChat = false, this.isVideo = false});

  _FullScreenImageWidgetState createState() => _FullScreenImageWidgetState();
}

class _FullScreenImageWidgetState extends State<FullScreenImageWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.photoUrl!,
                child: PhotoView(
                  imageProvider: NetworkImage(
                    widget.photoUrl != null ? widget.photoUrl.validate() : '',
                  ),
                  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                    return Image.asset('assets/placeholder.jpg');
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarWidget("${widget.name.validate().capitalizeFirstLetter()} ", textColor: Colors.white, color: Theme.of(context).primaryColor),
      body: body(),
    );
  }
}
