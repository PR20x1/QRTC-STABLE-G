#import <UIKit/UIKit.h>

%hook APMRemoteConfig
- (bool)checksumEnabled {
	return 0;
}
%end

%hook GNLCommonTools
+ (int)_checksumOfCRC32:(id)arg1 {
	return 0;
}
%end

%hook QCloudSimplePing
- (id)pingPacketWithType:(unsigned char)arg1 payload:(id)arg2 requiresChecksum:(bool)arg3 {
	arg3 = 0;
	arg2 = NULL;
	arg1 = 0;
	return NULL;
	return %orig;
}
%end

%hook AFSDKRouter
- (id)remoteDebugURL:(id)arg1 anonymizeUser:(bool)arg2 {
	return %orig;
}
%end

%hook AppsFlyerLib
- (bool)anonymizeUser {
	return 0;
}
%end

%hook AppsFlyerLib
- (void)setAnonymizeUser:(bool)arg1 {
	arg1 = 0;
	%orig;
}
%end

%hook AppsFlyerUtils
+ (id)retrievePersistedAnonymousID {
	return NULL;
}
%end

%hook FBSDKAppEvents
- (id)anonymousID {
	return NULL;
}
%end

%hook FBSDKBasicUtility
+ (id)anonymousID {
	return NULL;
}
%end

%hook FBSDKBasicUtility
+ (id)retrievePersistedAnonymousID {
	return NULL;
}
%end

%hook FBSDKBasicUtility
+ (void)persistAnonymousID:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook MSWeakTimer
- (id)initWithTimeInterval:(double)arg1 target:(id)arg2 selector:(SEL)arg3 userInfo:(id)arg4 repeats:(bool)arg5 dispatchQueue:(id)arg6 {
	return NULL;
}
%end

%hook MSWeakTimer
- (id)init {
	return NULL;
}
%end

%hook MSWeakTimer
- (void)setTolerance:(double)arg1 {
	arg1 = 0;
	%orig;
}
%end

%hook MSWeakTimer
- (void)resetTimerProperties {
}
%end

%hook MSWeakTimer
- (id)description {
	return NULL;
}
%end

%hook MSWeakTimer
- (double)tolerance {
	return 0;
}
%end

%hook MSWeakTimer
- (void)invalidate {
}
%end

%hook MSWeakTimer
- (void)setTimeInterval:(double)arg1 {
	arg1 = 0;
	%orig;
}
%end

%hook MSWeakTimer
- (id)target {
	return NULL;
}
%end

%hook MSWeakTimer
- (double)timeInterval {
	return 0;
}
%end

%hook MSWeakTimer
- (void)setTarget:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook MSWeakTimer
- (id)userInfo {
	return NULL;
}
%end

%hook MSWeakTimer
- (void)setUserInfo:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook MSWeakTimer
- (bool)repeats {
	return 0;
}
%end

%hook MSWeakTimer
- (void)setRepeats:(bool)arg1 {
	arg1 = 0;
	%orig;
}
%end

%hook MSWeakTimer
- (id)privateSerialQueue {
	return NULL;
}
%end

%hook MSWeakTimer
- (void)setPrivateSerialQueue:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook MSWeakTimer
- (id)timer {
	return NULL;
}
%end

%hook MSWeakTimer
- (void)setTimer:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook MSWeakTimer
+ (id)scheduledTimerWithTimeInterval:(double)arg1 target:(id)arg2 selector:(SEL)arg3 userInfo:(id)arg4 repeats:(bool)arg5 dispatchQueue:(id)arg6 {
	arg6 = NULL;
	arg5 = 0;
	arg4 = NULL;
	arg2 = NULL;
	arg1 = 0;
	return NULL;
	return %orig;
}
%end

%hook FBAdUtility
+ (id)anonymousIdentifier {
	return NULL;
}
%end

%hook FBAdBasicUtility
+ (void)persistAnonymousID:(id)arg1 {
	arg1 = NULL;
	%orig;
}
%end

%hook FBAdBasicUtility
+ (id)retrievePersistedAnonymousID {
	return NULL;
}
%end

%hook FBAdBasicUtility
+ (id)anonymousID {
	return NULL;
}
%end

%hook TssReachability
+ (id)reachabilityWithHostName:(id)arg1 {
	return NULL;
}
%end

%hook APMDeviceInfoSupportFrameworkLoad
+ (void)load {
}
%end

%hook APMTimeoutThreadManager
- (void)updateThread {
}
%end

%hook APMTimeoutThreadManager
- (void)checkTimeoutThreadAndWriteBacktrace {
}
%end

%hook APMTimeoutThreadManager
- (void)pushBlockInfo:(id)arg1 thread:(unsigned int)arg2 findBlockTime:(unsigned int)arg3 passedTime:(unsigned int)arg4 dumptime:(int)arg5 dumpAllThread:(bool)arg6 {
	arg1 = NULL;
	arg2 = 0;
	arg3 = 0;
	arg4 = 0;
	arg5 = 0;
	arg6 = 0;
	%orig;
}
%end
