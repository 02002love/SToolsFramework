//
//  ShowNumOfSeletedPics.h
//  FileTransfer
//
//  Created by HMC on 16/9/6.
//  Copyright © 2016年 SKing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SActionSheet : UIView

@property (copy, nonatomic) void (^btnClickedBlock)(NSInteger index);

/** 自定义初始化函数

 @param frame 大小
 @param cancelButtonTitle 取消按钮 不可空
 @param otherButtonTitles 操作类按钮
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame  cancelButtonTitle:(nonnull NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...  NS_REQUIRES_NIL_TERMINATION;

/** 将 View添加到 superview 上

 @param view 父视图
 */
-(void)showInSuperView:(UIView *)view;

-(void)hide;

NS_ASSUME_NONNULL_END

@end
