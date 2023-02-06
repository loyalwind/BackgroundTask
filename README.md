# BackgroundTask
进入后台申请延时任务

```objective-c
// 进入前台时
// [self.bgTask stopBgRuning];
[self.audioTask stopBgRuning];
```

```objective-c
// 完全进入后台时
// [self.bgTask startBgRuning]; // 普通短时任务申请
[self.audioTask startBgRuning]; // 长时音频任务申请
```




