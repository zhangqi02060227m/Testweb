//
//  TestCell.m
//  TestWeb
//
//  Created by huangbo on 17/5/17.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "TestCell.h"
#import "Masonry.h"
#import "TestModel.h"
#import "MTDefine.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"
@interface TestCell ()
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewTitle;

@end
@implementation TestCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self createView];
    }
    return self;
}


- (void)setModel:(TestModel *)model {
    _model = model;
    
//    [self.imgViewTitle sd_setShowActivityIndicatorView:YES];
//    [self.imgViewTitle sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    NSString *imgStr = [NSString stringWithFormat:@"https://img.zaozuo.com/%@", self.model.headImg];
    [self.imgViewTitle sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    self.labTitle.text = self.model.name;
    
}



//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    totalHeight += [self.labTitle sizeThatFits:size].height;
//    totalHeight += SCREENWIDTH * self.model.height / self.model.width;
//    return CGSizeMake(size.width, totalHeight);
//    
//}
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    //    self.imgViewTitle.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * self.model.height / self.model.width);
//    //    self.labTitle.frame = CGRectMake(10, self.imgViewTitle.frame.size.height, SCREENWIDTH - 20, self.contentView.frame.size.height - self.imgViewTitle.frame.size.height);
//    
//    
//    
//    
//    
//}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.labTitle.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
