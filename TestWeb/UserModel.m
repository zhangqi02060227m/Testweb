//
//  UserModel.m
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel *userModel = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [super allocWithZone:zone];
    });
    return userModel;
}


+ (id)copyWithZone:(struct _NSZone *)zone
{
    return userModel;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return userModel;
}


+ (UserModel *)shareUserModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[UserModel alloc] init];
    });
    return userModel;
}

- (void)mergeUserModel:(NSDictionary*)newDict {
    UserModel *user = [UserModel shareUserModel];
    user.userName =  [newDict valueForKey:@"UserName"];
    user.userNickName = [newDict valueForKey:@"UserNickName"];
    user.signature =  [newDict valueForKey:@"Signature"];
    user.avatar = [newDict valueForKey:@"Avatar"];
    user.categoryCode = [newDict valueForKey:@"CategoryCode"];
    user.categoryName = [newDict valueForKey:@"CategoryName"];
    if ([user.categoryCode isEqualToString:@"U00"]) {
        user.userMemberLevel = MTUserMemberLevelU00;
        
    } else if ([user.categoryCode isEqualToString:@"000"]) {
        user.userMemberLevel = MTUserMemberLevelNormal;
    } else if ([user.categoryCode isEqualToString:@"U01"]) {
        user.userMemberLevel = MTUserMemberLevelU01;
        
    } else if ([user.categoryCode isEqualToString:@"U02"]) {
        user.userMemberLevel = MTUserMemberLevelU02;
        
    } else if ([user.categoryCode isEqualToString:@"V01"]) {
        user.userMemberLevel = MTUserMemberLevelV01;
        
    } else if ([user.categoryCode isEqualToString:@"V02"]) {
        user.userMemberLevel = MTUserMemberLevelV02;
    } else {
        user.userMemberLevel = MTUserMemberLevelU00;
    }
    user.acctNo = [newDict valueForKey:@"AcctNo"];
    user.userID = ((NSString*)newDict[@"UserID"]).intValue;
}

@end
