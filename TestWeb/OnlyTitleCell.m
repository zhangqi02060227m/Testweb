//
//  OnlyTitleCell.m
//  TestWeb
//
//  Created by huangbo on 17/5/19.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "OnlyTitleCell.h"
#import "MTDefine.h"
@interface OnlyTitleCell ()
@property (nonatomic, strong) UILabel *labTitle;
@end

@implementation OnlyTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createVeiw];
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.labTitle.text = self.title;
}

- (void)createVeiw {
    self.labTitle = [[UILabel alloc] init];
    [self.contentView addSubview:self.labTitle];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
