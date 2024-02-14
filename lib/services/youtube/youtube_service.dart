/*
import 'package:http/http.dart' as http;
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

void authenticateWithYouTubeApi() async {
  const apiKey = 'YOUR_API_KEY';
  const scopes = [YouTubeApi.youtubeScope];
  final client = http.Client();
  final apiKeyClient = apiKey == null ? null : apiKeyBasedClient(apiKey);
  final credentials = apiKey == null
      ? await clientViaUserConsent(ClientId(null, null), scopes, client)
      : apiKeyClient;

  final youtube = YouTubeApi(credentials);
  // Now you can use 'youtube' object to make API calls

  final liveBroadcast = LiveBroadcastSnippet();
  liveBroadcast.title = 'My Livestream';
  liveBroadcast.scheduledStartTime = DateTime.now().toUtc().toIso8601String() as DateTime?;

  final youtubeLiveBroadcastsResource = youtube.liveBroadcasts;
  final liveBroadcastInsertRequest = youtubeLiveBroadcastsResource.insert(
    liveBroadcast.,
    part: 'snippet',
  );

  final liveBroadcastInsertResponse = await liveBroadcastInsertRequest.execute();
  final liveBroadcastId = liveBroadcastInsertResponse.id;
}
*/
