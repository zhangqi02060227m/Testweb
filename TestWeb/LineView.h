//
//  LineView.h
//  TestWeb
//
//  Created by huangbo on 17/5/8.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KDrawType) {
    KDrawTypeLine, // 划线
    KDrawTypeAny,
    KDrawTypeRect,
    KDrawTypeEllipse
};

@interface LineView : UIView

@property (nonatomic, strong) UIColor *stockColor;
@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, assign) KDrawType type;




@end
