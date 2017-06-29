//
//  PlayerMaskView.m
//  TestWeb
//
//  Created by huangbo on 17/6/1.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "PlayerMaskView.h"
#import "Masonry.h"
#import "MTDefine.h"
@interface PlayerMaskView ()
@property (nonatomic, strong) UIButton *btnPlay;
@property (nonatomic, strong) UIButton *btnBack;

@end
@implementation PlayerMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)createView {
    self.btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnPlay];
    [self.btnPlay addTarget:self action:@selector(handleBtnPlay) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.btnBack];
    [self.btnBack addTarget:self action:@selector(handleBtnBack) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)handleBtnPlay {
    if ([self.delegate respondsToSelector:@selector(play)]) {
        [self.delegate play];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        self.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.btnPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(50);
    }];
    

}




@end



