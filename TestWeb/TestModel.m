//
//  TestModel.m
//  TestWeb
//
//  Created by huangbo on 17/5/17.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

@end
