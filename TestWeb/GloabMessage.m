//
//  GloabMessage.m
//  TestWeb
//
//  Created by huangbo on 17/5/25.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "GloabMessage.h"

@implementation GloabMessage

+ (GloabMessage *)sharedGloabMessage {
    static GloabMessage *gloab = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gloab = [[GloabMessage alloc] init];
    });
    return gloab;
}

- (void)registerMessage:(id)name {
}


@end
