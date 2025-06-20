import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final class ChatPusherConfig {
  /// Singleton class

  ChatPusherConfig._();

  static final ChatPusherConfig _instance = ChatPusherConfig._();

  factory ChatPusherConfig() {
    return _instance;
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> init({
    required Function(PusherEvent event) onEvent,
  }) async {
    await pusher.init(
      apiKey: '9f752ff2758680389c5f',
      cluster: 'mt1',
      onEvent: onEvent,
    );
    await pusher.connect();
  }

  Future<PusherChannel> subscribeToChannel({
    required Function(PusherEvent event) onEvent,
    required int clintId,
    required int freelancerId,
  }) async {
    //chat-{client-id}-{freelancer-id}
    return await pusher.subscribe(
      channelName: 'chat-$clintId-$freelancerId',
      onEvent: onEvent,
    );
  }

  Future<void> unsubscribeFromChannel({
    required PusherChannel channel,
  }) async {
    await channel.unsubscribe();
  }

  Future<void> disconnect() async {
    await pusher.disconnect();
  }
}
