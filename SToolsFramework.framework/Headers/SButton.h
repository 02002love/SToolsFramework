//
//  SButton.h
//  SButton
//
//  Created by HMC on 2017/1/5.
//  Copyright © 2017年 HMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SButton : UIButton


/** 初始化 Button
 
 @param frame 大小位置
 @param bulletImg 发射的粒子图片
 @param isShowAnimation 是否执行动画
 @return obj
 */
- (instancetype)initWithFrame:(CGRect)frame bullet:(UIImage * )bulletImg isShowAnimation:(BOOL)isShowAnimation;
@end
