import 'dart:developer';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

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
    await _pusher.init(
      apiKey: '9f752ff2758680389c5f',
      cluster: 'mt1',
      //authEndpoint: '',
      logToConsole: true,
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
    required Function(PusherEvent? event) onEvent,
    required int chatId,
  }) async {

    /// USER = chat-94-98
    /// FREELANCER = chat-94-98


   // log('MY CHANEL NAME: chat-$clintId-$freelancerId');
    return await _pusher.subscribe(
      channelName: 'private-chat.$chatId',
      onEvent: (dynamic event) {
        onEvent(event as PusherEvent?);
      },
    );
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
