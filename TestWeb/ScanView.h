//
//  ScanView.h
//  TestWeb
//
//  Created by huangbo on 17/5/24.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanView : UIView

@property (nonatomic, strong) UIColor *cornerColor; // 四个角落的颜色
@property (nonatomic, assign) CGFloat lineWidth; // 是个角落的线宽
@property (nonatomic, assign) CGSize scanArea; // 扫描的区域

@end
