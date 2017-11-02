# NFCDemo
## NFC 近场通讯：近距离无线通讯技术（一种近距离的高频无线通信技术）
工作模式：卡模式、点对点模式、读卡器模式<br>
同类对比 --> 蓝牙Bluetooth  <br>
设置程序较短但无法达到蓝牙的低功率<br>
Core NFC 被描述为“一种用NFC数据交换格式读取NFC标签和数据的框架”<br>
NDEF    NFC 数据交换格式  NFC data exchange format 	<br>
## 使用NFC   iOS11.0+
创建一个工程，确保能添加NFC的capabilities。在storyboard的画布上添加一个button，建立与相应.m文件的action touchUpInside事件。使其实现点击开启一个60s的session。
## 1、	配置Capabilities 
![image](https://github.com/bumingxialuo/NFCDemo/blob/master/images/1.png)
## 2、在 yourProject.entitlements 中添加
```shell
<key>com.apple.developer.nfc.readersession.formats</key>
	<array>
		<string>NDEF</string>
	</array>
```
在属性列表中长这样<br>
![image](https://github.com/bumingxialuo/NFCDemo/blob/master/images/3.png)
## 3、打开隐私相关设置 在info.plist中添加
```shell
<key>NFCReaderUsageDescription</key>
    <string>NFC Tag!</string>
```
在属性列表中长这样<br>
![image](https://github.com/bumingxialuo/NFCDemo/blob/master/images/2.png)
## 4、import CoreNFC
```oc
#import <CoreNFC/CoreNFC.h>
```
## 5、实现NFCNDEFReaderSessionDelegate协议
```oc
@interface ViewController ()<NFCNDEFReaderSessionDelegate>
@property (nonatomic, strong) NFCNDEFReaderSession *session;
@end
```

## 6、在点击方法中，检查设备是否支持NFC，支持的话，创建一个session
```oc
if ([NFCNDEFReaderSession readingAvailable])
       {
            _session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:YES];
            
            [_session beginSession];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"设备不支持" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
        }
```

## 7、处理协议回调方法
必须使用的两个方法<br>
```oc
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    for (NFCNDEFMessage *message in messages) {
        for (NFCNDEFPayload *payload in message.records) {
            NSLog(@"Payload data:%@",payload.payload);
        }
    }
}
- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"出现错误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [_session invalidateSession];
    }];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"error: %@",error);
}
```
<br>
<br>
<br>
<br>

## 参考文章<br>
http://www.jianshu.com/p/2c93d96bb084<br>
https://developer.apple.com/documentation/corenfc#overview<br>
https://stackoverflow.com/questions/44380305/ios-11-core-nfc-any-sample-code<br>


