//
//  MTMessageView.h
//  TestWeb
//
//  Created by huangbo on 17/5/15.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MTClickCancel)();
typedef void(^MTClickConfirm)(NSString *message);

@interface MTMessageView : UIView


- (void)clickCancelBlock:(void (^)())block;
- (void)clickConfirmBlock:(void (^)(NSString *msg))block;

- (void)showMessageView;
- (void)removeMessageView;

@property (nonatomic, copy) NSString *title;  // derfault 标题
@property (nonatomic, strong) UIFont *titleFont; // default 16.0
@property (nonatomic, strong) UIColor *titleColor; // default 
@property (nonatomic, copy) NSString *msgStr;
@property (nonatomic, strong) UIFont *msgFont;
@property (nonatomic, strong) UIColor *msgColor;




@end
