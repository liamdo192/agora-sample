import React from 'react';
import {SafeAreaView} from 'react-native';
import {Case1} from './Case1';

export const YOUR_AGORA_ID = '';
export const YOUR_AGORA_TOKEN = '';
export const YOUR_CHANNEL_ID = '';
export const YOUR_USER_ACCOUNT = '';

export default function App() {
  return (
    <SafeAreaView
      style={{
        flex: 1,
        backgroundColor: 'white',
        justifyContent: 'center',
        alignItems: 'center',
      }}>
      <Case1 />
    </SafeAreaView>
  );
}
