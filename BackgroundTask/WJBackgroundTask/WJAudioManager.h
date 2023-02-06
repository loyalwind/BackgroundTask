//
//  WJAudioManager.h
//  BackgroundTask
//
//  Created by pengweijian on 2023/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJAudioManager : NSObject
/// 单例
+ (instancetype)shared;
/// 是否开启后台自动播放无声音乐
@property (nonatomic, assign) BOOL  openBackgroundAudioAutoPlay;
@end

NS_ASSUME_NONNULL_END
