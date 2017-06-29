//
//  PlayerMaskView.h
//  TestWeb
//
//  Created by huangbo on 17/6/1.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayerMaskViewDelegate  <NSObject>

- (void)play;

@end

@interface PlayerMaskView : UIView

@property (nonatomic, weak) id <PlayerMaskViewDelegate> delegate;

@end
