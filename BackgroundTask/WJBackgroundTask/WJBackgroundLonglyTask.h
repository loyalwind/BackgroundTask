//
//  WJBackgroundLonglyTask.h
//  BackgroundTask
//
//  Created by pengweijian on 2023/1/31.
//  长时间后台任务

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSInteger WJBgTaskDurationMaxium;
UIKIT_EXTERN NSInteger WJBgTaskDurationMinium;
UIKIT_EXTERN NSInteger WJBgTaskDurationMedium;

NS_ASSUME_NONNULL_BEGIN

@interface WJBackgroundLonglyTask : NSObject
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSUInteger loopCount;
/// 后台任务持续时长
/// - Parameters:
///   - duration: 后台任务时长 10的倍数，>=30以上
///   - interval: 后台任务每次执行时间间隔
- (instancetype)initWithInterval:(NSUInteger)interval;
- (void)startBgRuning;
- (void)stopBgRuning;
- (void)onStartTask;
- (void)onStopTask;
@end

NS_ASSUME_NONNULL_END
