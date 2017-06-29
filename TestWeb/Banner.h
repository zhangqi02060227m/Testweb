//
//  Banner.h
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
@property (nonatomic,copy) NSString *bannerImage;
@property (nonatomic,copy) NSString *bannerText;
@property (nonatomic,copy) NSString *bannerUrl;
+ (Banner *)mergeBannerResult:(NSDictionary *)dic;
- (instancetype)initWithResult:(NSDictionary *)dic;
@end
