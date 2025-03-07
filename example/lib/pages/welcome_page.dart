import 'dart:io';


import '../constants.dart';
import '../utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'auto_fullscreen_orientation_page.dart';
import 'basic_player_page.dart';
import 'cache_page.dart';
import 'change_player_theme_page.dart';
import 'controller_controls_page.dart';
import 'controls_always_visible_page.dart';
import 'controls_configuration_page.dart';
import 'drm_page.dart';
import 'event_listener_page.dart';
import 'fade_placeholder_page.dart';
import 'hls_audio_page.dart';
import 'hls_subtitles_page.dart';
import 'hls_tracks_page.dart';
import 'memory_player_page.dart';
import 'normal_player_page.dart';
import 'notification_player_page.dart';
import 'overridden_aspect_ratio_page.dart';
import 'overriden_duration_page.dart';
import 'picture_in_picture_page.dart';
import 'placeholder_until_play_page.dart';
import 'playlist_page.dart';
import 'resolutions_page.dart';
import 'reusable_video_list/reusable_video_list_page.dart';
import 'rotation_and_fit_page.dart';
import 'subtitles_page.dart';
import 'video_list/video_list_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _saveAssetSubtitleToFile();
    _saveAssetVideoToFile();
    _saveLogoToFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Better Player Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Image.asset(
              "assets/logo.png",
              height: 200,
              width: 200,
            ),
            Text(
              "Welcome to Better Player example app. Click on any element below to see example.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...buildExampleElementWidgets()
          ],
        ),
      ),
    );
  }

  List<Widget> buildExampleElementWidgets() {
    return [
      _buildExampleElementWidget("Basic player", () {
        _navigateToPage(BasicPlayerPage());
      }),
      _buildExampleElementWidget("Normal player", () {
        _navigateToPage(NormalPlayerPage());
      }),
      _buildExampleElementWidget("Controls configuration", () {
        _navigateToPage(ControlsConfigurationPage());
      }),
      _buildExampleElementWidget("Event listener", () {
        _navigateToPage(EventListenerPage());
      }),
      _buildExampleElementWidget("Subtitles", () {
        _navigateToPage(SubtitlesPage());
      }),
      _buildExampleElementWidget("Resolutions", () {
        _navigateToPage(ResolutionsPage());
      }),
      _buildExampleElementWidget("HLS subtitles", () {
        _navigateToPage(HlsSubtitlesPage());
      }),
      _buildExampleElementWidget("HLS tracks", () {
        _navigateToPage(HlsTracksPage());
      }),
      _buildExampleElementWidget("HLS Audio", () {
        _navigateToPage(HlsAudioPage());
      }),
      _buildExampleElementWidget("Cache", () {
        _navigateToPage(CachePage());
      }),
      _buildExampleElementWidget("Playlist", () {
        _navigateToPage(PlaylistPage());
      }),
      _buildExampleElementWidget("Video in list", () {
        _navigateToPage(VideoListPage());
      }),
      _buildExampleElementWidget("Rotation and fit", () {
        _navigateToPage(RotationAndFitPage());
      }),
      _buildExampleElementWidget("Memory player", () {
        _navigateToPage(MemoryPlayerPage());
      }),
      _buildExampleElementWidget("Controller controls", () {
        _navigateToPage(ControllerControlsPage());
      }),
      _buildExampleElementWidget("Auto fullscreen orientation", () {
        _navigateToPage(AutoFullscreenOrientationPage());
      }),
      _buildExampleElementWidget("Overridden aspect ratio", () {
        _navigateToPage(OverriddenAspectRatioPage());
      }),
      _buildExampleElementWidget("Overridden aspect ratio", () {
        _navigateToPage(OverriddenAspectRatioPage());
      }),
      _buildExampleElementWidget("Notifications player", () {
        _navigateToPage(NotificationPlayerPage());
      }),
      _buildExampleElementWidget("Reusable video list", () {
        _navigateToPage(ReusableVideoListPage());
      }),
      _buildExampleElementWidget("Fade placeholder", () {
        _navigateToPage(FadePlaceholderPage());
      }),
      _buildExampleElementWidget("Placeholder until play", () {
        _navigateToPage(PlaceholderUntilPlayPage());
      }),
      _buildExampleElementWidget("Change player theme", () {
        _navigateToPage(ChangePlayerThemePage());
      }),
      _buildExampleElementWidget("Overridden duration", () {
        _navigateToPage(OverriddenDurationPage());
      }),
      _buildExampleElementWidget("Picture in Picture", () {
        _navigateToPage(PictureInPicturePage());
      }),
      _buildExampleElementWidget("Controls always visible", () {
        _navigateToPage(ControlsAlwaysVisiblePage());
      }),
      _buildExampleElementWidget("DRM", () {
        _navigateToPage(DrmPage());
      }),
    ];
  }

  Widget _buildExampleElementWidget(String name, Function onClicked) {
    return Material(
      child: InkWell(
        onTap: onClicked as void Function()?,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future _navigateToPage(Widget routeWidget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routeWidget),
    );
  }

  ///Save subtitles to file, so we can use it later
  Future _saveAssetSubtitleToFile() async {
    String content =
        await rootBundle.loadString("assets/example_subtitles.srt");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/example_subtitles.srt");
    file.writeAsString(content);
  }

  ///Save video to file, so we can use it later
  Future _saveAssetVideoToFile() async {
    var content = await rootBundle.load("assets/testvideo.mp4");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/testvideo.mp4");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }

  ///Save logo to file, so we can use it later
  Future _saveLogoToFile() async {
    var content = await rootBundle.load("assets/${Constants.logo}");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/${Constants.logo}");
    file.writeAsBytesSync(content.buffer.asUint8List());
  }
}
