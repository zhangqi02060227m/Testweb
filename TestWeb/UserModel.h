//
//  UserModel.h
//  TestWeb
//
//  Created by huangbo on 17/5/5.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_MANAGER_INSTANCE [UserModel shareUserModel]

typedef NS_ENUM(NSUInteger, MTUserMemberLevel) {
    MTUserMemberLevelU00 = 0, // 游客
    MTUserMemberLevelNormal,// 普通注册用户
    MTUserMemberLevelU01, // 白银会员
    MTUserMemberLevelU02, // 黄金会员
    MTUserMemberLevelV01, // 钻石会员
    MTUserMemberLevelV02  // 至尊会员
};

@interface UserModel : NSObject


@property (copy,nonatomic) NSString *userName;
@property (copy,nonatomic) NSString *userNickName;
@property (copy,nonatomic) NSString *avatar;
@property (copy,nonatomic) NSString *signature;
@property (copy,nonatomic) NSString *categoryCode;
@property (copy,nonatomic) NSString *categoryName;
@property (copy,nonatomic) NSString *acctNo;
@property (assign,nonatomic) int userID;

// 用户的等级
@property (nonatomic, assign) MTUserMemberLevel userMemberLevel;

+ (UserModel *)shareUserModel;
- (void)mergeUserModel:(NSDictionary*)newDict;

@end
