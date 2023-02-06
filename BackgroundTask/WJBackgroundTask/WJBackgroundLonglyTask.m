//
//  WJBackgroundLonglyTask.m
//  BackgroundTask
//
//  Created by pengweijian on 2023/1/31.
//

#import "WJBackgroundLonglyTask.h"
#import <AVFAudio/AVFAudio.h>

NSInteger WJBgTaskDurationMaxium = 600;
NSInteger WJBgTaskDurationMinium = 60;
NSInteger WJBgTaskDurationMedium = 180;

@interface WJBackgroundLonglyTask ()
@property (nonatomic, strong) NSTimer *timer;
/// 后台任务时长 10的倍数，>=30以上
@property (nonatomic, assign) NSUInteger interval;
@end

#define REGISTER_NOTIFY(note, sel) [NSNotificationCenter.defaultCenter addObserver:self selector:sel name:note object:nil]

@implementation WJBackgroundLonglyTask

- (instancetype)initWithInterval:(NSUInteger)interval {
    if (self = [super init]) {
        self.interval = MAX(10, interval);
        self.duration = WJBgTaskDurationMedium;
    }
    return self;
}
- (NSTimer *)timer {
    if(!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(startTask) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

- (void)removeTimer{
    if (_timer) {
        _timer.fireDate = NSDate.distantFuture;
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 后台任务延长时间
- (void)startBgRuning {
    NSLog(@"%s", __func__);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startTask) object:nil];
    self.loopCount = self.duration / self.interval;
    [self removeTimer];
    if(self.loopCount > 0){
        self.timer.fireDate = NSDate.distantPast;
    }
}

- (void)stopBgRuning {
    NSLog(@"%s", __func__);
    [self removeTimer];
    [self onStopTask];
}

- (void)startTask {
        // 超过时间, 后台任务
    if (self.loopCount > 0) {
        [self onStartTask];
    } else {
        [self stopBgRuning];
    }
    self.loopCount--;
}

- (void)onStartTask {
    NSLog(@"%s -- %ld", __func__, self.loopCount);
}

- (void)onStopTask {
    NSLog(@"%s", __func__);
}
@end
