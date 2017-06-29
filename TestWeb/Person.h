//
//  Person.h
//  TestWeb
//
//  Created by huangbo on 17/5/8.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Person : NSObject<NSCoding, NSCopying>

@property (nonatomic,assign) NSInteger age; // 年龄integer类型

@property (nonatomic,copy) NSString *name; // 姓名，oc对象类型

@property (nonatomic,strong) UIImage *image; // 图片，UIImage类型
@end
