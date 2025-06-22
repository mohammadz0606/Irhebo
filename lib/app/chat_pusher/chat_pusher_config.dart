import 'dart:developer';
import 'dart:io';

import 'package:irhebo/app/global_imports.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../network/network.dart';

final class ChatPusherConfig {
  /// Singleton class

  ChatPusherConfig._();

  static final ChatPusherConfig _instance = ChatPusherConfig._();

  factory ChatPusherConfig() {
    return _instance;
  }

  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  Future<void> init({
    required Function(PusherEvent event) onEvent,
  }) async {
    final AppPreferences preferences = sl();
    final String? token = preferences.getString(key: AppPrefsKeys.TOKEN);
    await _pusher.init(
      apiKey: '9f752ff2758680389c5f',
      cluster: 'mt1',
      authEndpoint: '${AppEndpoints.base_url}/broadcasting/auth',
      onAuthorizer: (channelName, socketId, options) async {
        log('🔥 [onAuthorizer pusher]');

        final response = await Network().post(
          url: '${AppEndpoints.base_url}/broadcasting/auth',
          data: {
            'socket_id': socketId,
            'channel_name': channelName,
          },
        );
        log('socketId: $socketId');
        log('channelName: $channelName');
        log(response.data);
        log('socketId: $socketId');
        log('channelName: $channelName');

        return response.data;

      },
      authParams: {
        'headers': {
          if (token != null) 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }
      },
      logToConsole: true,
      enableStats: true,
      onSubscriptionSucceeded: (channelName, data) {
        log('🔥 [onSubscriptionSucceeded pusher]');
        log('DATA: $data');
        log('channelName: $channelName');
      },
      onSubscriptionCount: (channelName, subscriptionCount) {
        log('🔥 [onSubscriptionCount pusher]');
        log('DATA: $subscriptionCount');
        log('channelName: $channelName');
      },
      onEvent: (event) {
        log('🔥 [PUSHER EVENT]');
        log('channel: ${event.channelName}');
        log('event: ${event.eventName}');
        log('data: ${event.data}');
        onEvent(event);
      },
      onError: (message, code, error) {
        log('Pusher error: $message, $code, $error');
      },
      onConnectionStateChange: (currentState, previousState) {
        log('onConnectionStateChange: ${currentState.toString()}');
      },
    );

    await _pusher.connect();
  }

  Future<PusherChannel> subscribeToChannel({
    required int chatId,
  }) async {
    return await _pusher.subscribe(
      channelName: 'chat.$chatId',
      //channelName: 'test-channel',
    );
  }

  onEvent() {
    return _pusher.onEvent = (PusherEvent event) {
      if (event.channelName == 'private-chat.123' &&
          event.eventName == 'new-message') {
        log("📩 Message received: ${event.data}");
      }
    };
  }

  Future<void> unsubscribeFromChannel({
    required PusherChannel channel,
  }) async {
    await channel.unsubscribe();
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
  }
}
