//
//  Person.m
//  TestWeb
//
//  Created by huangbo on 17/5/8.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "Person.h"

@implementation Person

// 归档的过程是一个编码的过程，对象内部属性需要进行编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    // 注意1：编码时，需要注意，不同类型的实例变量，使用不同的编码方式
    // person 中 age 为integer 类型， name 为 nsstring 类型，image 为 UIImage类型
    
    // 注意2：编码时，需要在编码时加上标记；编码 data型数据时，不需要加标记。
    
    
    [aCoder encodeInteger:_age forKey:@"age"];  // 类型：integer  标记：age
    
    [aCoder encodeObject:_name forKey:@"name"]; // 类型：nsstring 标记：name
    
    [aCoder encodeDataObject:UIImagePNGRepresentation(_image)]; // 类型：data 标记：不需要
    
}

// 反归档，是一个解码过程。解码过程，是一个重新创建对象的过程，因此，解码方法是一个初始化方法。 init开头
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super init];
    
    if (self) {
        
        
        // 解码，给内部对象赋值, 选择对应类型的解码方法 和 标记解码。
        self.age =  [aDecoder decodeIntegerForKey:@"age"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.image = [UIImage imageWithData:[aDecoder decodeDataObject]];
        
    }
    
    return self;
    
}

- (id)copyWithZone:(NSZone *)zone {
    Person *copy = [[[self class] allocWithZone:zone] init];
    
    // 拷贝名字给副本对象
    copy.name = self.name;
    copy.age = self.age;
    
    return copy;
}


@end
