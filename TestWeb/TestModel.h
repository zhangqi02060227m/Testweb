//
//  TestModel.h
//  TestWeb
//
//  Created by huangbo on 17/5/17.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *name;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
