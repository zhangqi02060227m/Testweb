//
//  ImageTitleView.h
//  TestWeb
//
//  Created by huangbo on 17/5/22.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ViewStyle) {
    ViewStyleImageLeft,
    ViewStyleImageTop,
};

@interface ImageTitleView : UIView

@property (nonatomic, assign) ViewStyle style;
@property (nonatomic, copy) NSString *imgTitle;
@property (nonatomic, copy) NSString *title;

- (void)addTarget:(id)target action:(SEL)action;

@end
