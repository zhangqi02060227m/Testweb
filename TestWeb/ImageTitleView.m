//
//  ImageTitleView.m
//  TestWeb
//
//  Created by huangbo on 17/5/22.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "ImageTitleView.h"
#import "MTDefine.h"
#import "Masonry.h"

@interface ImageTitleView ()
@property (nonatomic, strong) UIImageView *imgViewTitle;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labBadgeBg;
@property (nonatomic, strong) UILabel *labBadge;
@end

@implementation ImageTitleView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setImgTitle:(NSString *)imgTitle {
    _imgTitle = imgTitle;
    self.imgViewTitle.image = [[UIImage imageNamed:self.imgTitle] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.labTitle.text = self.title;
}

- (void)createView {
    
    self.style = ViewStyleImageLeft;
    
    self.imgViewTitle = [[UIImageView alloc] init];
    [self addSubview:self.imgViewTitle];
    
    self.labTitle = [[UILabel alloc] init];
    [self addSubview:self.labTitle];
    
    self.labBadgeBg = [[UILabel alloc] init];
    [self addSubview:self.labBadgeBg];
    self.labBadgeBg.backgroundColor = [UIColor redColor];
    self.labBadgeBg.layer.masksToBounds = YES;

    
    self.labBadge = [[UILabel alloc] init];
    [self addSubview:self.labBadge];
    self.labBadge.font = [UIFont systemFontOfSize:12];
    
    self.labBadge.text = @"99+";

}

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.style == ViewStyleImageLeft) {
        [self.imgViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(20);
        }];
        [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgViewTitle.mas_right).offset(5);
            make.centerY.mas_equalTo(self);
        }];
    } else if (self.style == ViewStyleImageTop) {
        [self.imgViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(40);
            make.top.mas_equalTo(10);
        }];
        [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgViewTitle.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
        }];
        [self.labBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.imgViewTitle.mas_top);
            make.centerX.mas_equalTo(self.imgViewTitle.mas_right);
        }];
        [self layoutIfNeeded];
        CGFloat h = 0;
        if (self.labBadge.frame.size.height > self.labBadge.frame.size.width) {
            h = self.labBadge.frame.size.height;
        } else {
            h = self.labBadge.frame.size.width + 6;
        }
        [self.labBadgeBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self.labBadge);
            make.width.mas_equalTo(h);
            make.height.mas_equalTo(h);

        }];
        
        
        
        
        self.labBadgeBg.layer.cornerRadius = h / 2;
    }
    

}


@end
