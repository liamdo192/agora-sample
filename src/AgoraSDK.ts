import {
  AudioSessionOperationRestriction,
  ChannelProfileType,
  ClientRoleType,
  createAgoraRtcEngine,
  IRtcEngine,
} from 'react-native-agora';
import {
  YOUR_AGORA_ID,
  YOUR_AGORA_TOKEN,
  YOUR_CHANNEL_ID,
  YOUR_USER_ACCOUNT,
} from './App';

export class AgoraSDK {
  private static instance: AgoraSDK;
  private engine?: IRtcEngine;

  public static getInstance(): AgoraSDK {
    if (!AgoraSDK.instance) {
      AgoraSDK.instance = new AgoraSDK();
    }
    return AgoraSDK.instance;
  }

  initialize(appId: string) {
    this.engine = createAgoraRtcEngine();
    this.engine.initialize({
      appId,
      channelProfile: ChannelProfileType.ChannelProfileLiveBroadcasting,
    });
    this.engine.setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction.AudioSessionOperationRestrictionAll,
    );

    this.engine.enableVideo();
    this.engine.enableAudio();
    this.engine.enableLocalAudio(true);
  }

  togglePreview(isPreview: boolean) {
    if (isPreview) {
      this.initialize(YOUR_AGORA_ID);
      this.engine?.joinChannelWithUserAccount(
        YOUR_AGORA_TOKEN,
        YOUR_CHANNEL_ID,
        YOUR_USER_ACCOUNT,
        {
          clientRoleType: ClientRoleType.ClientRoleBroadcaster,
        },
      );
    } else {
      this.engine?.release();
    }
  }
}
