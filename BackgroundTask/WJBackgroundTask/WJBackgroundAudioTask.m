//
//  WJBackgroundAudioTask.m
//  BackgroundTask
//
//  Created by pengweijian on 2023/1/31.
//

#import "WJBackgroundAudioTask.h"
#import <AVFAudio/AVFAudio.h>

@interface WJBackgroundAudioTask ()
@property (nonatomic, copy) NSURL *audioURL;/// 播放文件
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end
//const char * kModes[] = {"audio", "bluetooth-central", "bluetooth-peripheral", "external-accessory", "fetch", "location", "nearby-interaction", "processing",  "push-to-talk",  "remote-notification", "voip"};

@implementation WJBackgroundAudioTask
- (instancetype)initWithInterval:(NSUInteger)interval {
    if (self = [super initWithInterval:interval]) {
        NSArray *modes = [NSBundle.mainBundle objectForInfoDictionaryKey:@"UIBackgroundModes"];
        if ([modes containsObject:@"audio"]) {
            NSString *audioFile = [NSBundle.mainBundle pathForResource:@"WJBackgroundTask.bundle/silenceBg.mp3" ofType:nil];
            self.audioURL = [[NSURL alloc] initFileURLWithPath:audioFile];
        }
    }
    return self;
}

- (AVAudioPlayer *)audioPlayer {
    if (!_audioPlayer) {
        // 0.0~1.0,默认为1.0
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioURL error:&error];
        _audioPlayer.volume = 0;
        // 循环播放 保活在后台导航时 容易不生效
        _audioPlayer.numberOfLoops = -1;
        [_audioPlayer prepareToPlay];
    }
    return _audioPlayer;
}

#pragma mark - 后台任务延长时间
- (void)onStartTask {
    NSLog(@"%s : 第 %ld 次", __func__, self.loopCount);
    // *让app接受远程事件控制，及锁屏是控制版会出现播放按钮 https://www.jianshu.com/p/5b3a920db773
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 其他播放类应用将混合播放
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    // 其他播放类应用将暂停播放
    // [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活app音效
    [session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    if(self.audioURL){
        [self.audioPlayer play];
    }
}

- (void)onStopTask {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 一 解除app音效，其他被该app暂停的播放类应用将恢复播放
    [session setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    [_audioPlayer stop];
    _audioPlayer = nil;
}

@end
