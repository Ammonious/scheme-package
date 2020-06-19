import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController useVideoController({String asset, String url}) =>
    Hook.use(_VideoPlayerControllerHook(asset: asset, url: url));

class _VideoPlayerControllerHook extends Hook<VideoPlayerController> {
  final String asset;
  final String url;
  const _VideoPlayerControllerHook({this.asset, this.url});

  @override
  VideoPlayerControllerHookState createState() => VideoPlayerControllerHookState();
}

class VideoPlayerControllerHookState
    extends HookState<VideoPlayerController, _VideoPlayerControllerHook> {
  VideoPlayerController _controller;

  @override
  void initHook() {
  	if(hook.asset != null){
		  _controller = VideoPlayerController.asset(hook.asset)
			  ..initialize().then((_) =>  setState(() { }));
	  } else if(hook.url != null){
		  _controller = VideoPlayerController.network(hook.asset)
			  ..initialize().then((_) =>  setState(() { }));
	  }

  }

  // Build doesn't return a Widget but rather the VideoPlayerController
  @override
  VideoPlayerController build(BuildContext context) => _controller;

  // This is what we came here for
  @override
  void dispose() => _controller.dispose();
}
