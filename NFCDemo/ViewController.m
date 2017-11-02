//
//  ViewController.m
//  NFCDemo
//
//  Created by xia on 2017/11/1.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "ViewController.h"
#import <CoreNFC/CoreNFC.h>

@interface ViewController ()<NFCNDEFReaderSessionDelegate>
@property (nonatomic, strong) NFCNDEFReaderSession *session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtnClick:(id)sender {
        if ([NFCNDEFReaderSession readingAvailable]) {
            _session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:YES];
            
            [_session beginSession];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"设备不支持" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancel];
            [self presentViewController:alertController animated:YES completion:nil];
        }
}

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


@end
