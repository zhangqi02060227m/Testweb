//
//  Banner.m
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "Banner.h"

@implementation Banner


- (instancetype)initWithResult:(NSDictionary *)dic {
    self = [super init];
    if (self ) {
        self.bannerImage = dic[@"BannerImage"];
        self.bannerText = dic[@"BannerText"];
        self.bannerUrl = dic[@"BannerUrl"];
    }
    return self;

}

+ (Banner *)mergeBannerResult:(NSDictionary *)dic {
    Banner *banner = [[Banner alloc] init];
    banner.bannerImage = dic[@"BannerImage"];
    banner.bannerText = dic[@"BannerText"];
    banner.bannerUrl = dic[@"BannerUrl"];

    return banner;
}

@end
