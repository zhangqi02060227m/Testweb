//
//  MTDefine.h
//  TestWeb
//
//  Created by huangbo on 17/5/15.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#ifndef MTDefine_h
#define MTDefine_h

#import "Masonry.h"


#ifdef DEBUG  //调试阶段

#define NSLog(...)  NSLog(__VA_ARGS__)

#else //发布阶段

#define NSLog(...)

#endif

#define MTWeakSelf __weak typeof(self) weakSelf = self;
#define MTHexColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0  blue:((c)&0xFF)/255.0 alpha:1.0]
#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height

#define MTRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define MTRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


#define MTRandColor MTRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define MTPropertyStrong @property (nonatomic, strong)

#endif /* MTDefine_h */
