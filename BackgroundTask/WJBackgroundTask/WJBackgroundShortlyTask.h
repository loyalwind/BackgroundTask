//
//  WJBackgroundShortlyTask.h
//  BackgroundTask
//
//  Created by pengweijian on 2023/1/31.
//  短时间后台任务 30秒

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJBackgroundShortlyTask : NSObject
/// 运行后台任务
- (void)startBgRuning;
/// 停止后台任务
- (void)stopBgRuning;
- (void)onStartTask;
- (void)onStopTask;
@end

NS_ASSUME_NONNULL_END
