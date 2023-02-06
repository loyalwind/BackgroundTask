//
//  WJBackgroundShortlyTask.m
//  BackgroundTask
//
//  Created by pengweijian on 2023/1/31.
//

#import "WJBackgroundShortlyTask.h"
#import <AVFAudio/AVFAudio.h>

@interface WJBackgroundShortlyTask ()
/** 后台任务id */
@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTaskIdentifier;
@end

@implementation WJBackgroundShortlyTask

#pragma mark - 后台任务延长时间
- (void)startBgRuning {
    NSLog(@"%s", __func__);
    self.bgTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTaskIdentifier];
        self.bgTaskIdentifier = UIBackgroundTaskInvalid;
    }];
    [self onStartTask];
}

- (void)stopBgRuning {
    NSLog(@"%s", __func__);
    if (self.bgTaskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTaskIdentifier];
        self.bgTaskIdentifier = UIBackgroundTaskInvalid;
    }

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(onStartTask) object:nil];
    [self onStopTask];
}

- (void)onStartTask {
    NSLog(@"%s", __func__);
    /**
    // *让app接受远程事件控制，及锁屏是控制版会出现播放按钮 https://www.jianshu.com/p/5b3a920db773
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession*session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 一 解除app音效，其他被该app暂停的播放类应用将恢复播放
    [session setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    // 二 解除app音效，其他播放类应用不会恢复播放
    // [session setActive:NO error:nil];
     */
}

- (void)onStopTask {
    NSLog(@"%s", __func__);
    /**
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    AVAudioSession*session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活app音效，其他播放类应用将暂停播放
    [session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
     */
}

@end
