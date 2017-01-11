//
//  FlushLab.h
//  AnimatedMaskLabel
//
//  Created by HMC on 2016/12/6.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLabel : UILabel

/** 初始化

 @param frame 大小位置
 @param text  label 的 title
 @return obj
 */
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor * )textColor font:(UIFont *)font;

-(void)setFlushStyle:(BOOL) isFlush;

@end
