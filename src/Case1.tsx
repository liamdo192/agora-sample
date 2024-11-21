import React, {useEffect, useState} from 'react';
import {NativeModules, Text, TouchableOpacity, View} from 'react-native';
import {RtcSurfaceView, VideoViewSetupMode} from 'react-native-agora';
import Video from 'react-native-video';
import {AgoraSDK} from './AgoraSDK';
const {GSAudioManager} = NativeModules;

export function Case1() {
  const [isJoined, setJoined] = useState(false);

  useEffect(() => {
    GSAudioManager.setAudioCategory();
    const interval = setInterval(() => {
      GSAudioManager.getAudioCategory();
    }, 2000);

    return () => {
      clearInterval(interval);
    };
  }, []);

  const handleJoin = () => {
    setJoined(prev => !prev);
    AgoraSDK.getInstance().togglePreview(!isJoined);
  };

  return (
    <View>
      <Video
        source={{
          uri: 'https://cdn.freesound.org/previews/767/767937_15232790-lq.mp3',
        }}
        paused={true}
        repeat
        playInBackground={false}
        style={{width: 320, height: 180}}
        controls
      />

      <TouchableOpacity
        style={{
          backgroundColor: 'blue',
          paddingHorizontal: 20,
          paddingVertical: 10,
          justifyContent: 'center',
          alignItems: 'center',
          marginTop: 12,
        }}
        onPress={handleJoin}>
        <Text style={{color: 'white'}}>
          {!isJoined ? 'Join Agora Session' : 'Leave Session'}
        </Text>
      </TouchableOpacity>

      {isJoined && (
        <RtcSurfaceView
          style={{
            marginTop: 12,
            width: 320,
            height: 180,
          }}
          canvas={{
            uid: 0,
            setupMode: VideoViewSetupMode.VideoViewSetupReplace,
          }}
        />
      )}
    </View>
  );
}
