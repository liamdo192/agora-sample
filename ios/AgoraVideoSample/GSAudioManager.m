#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(GSAudioManager, NSObject)

RCT_EXTERN_METHOD(setAudioCategory);
RCT_EXTERN_METHOD(getAudioRouteAvailable);
RCT_EXTERN_METHOD(setAudioRoute:(NSInteger)route)
RCT_EXTERN_METHOD(getAudioCategory);
RCT_EXTERN_METHOD(deactiveAudioSession);

@end


