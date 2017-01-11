//
//  myAlert.h
//  customAlert
//
//  Created by HMC on 16/7/6.
//  Copyright © 2016年 SKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAlertView;
/**
 *  代理方法
 */
@protocol SAlertViewDelegate <NSObject>

@required

/**
 *  代理方法
 *
 *  @param sAlert            alertView
 *  @param buttonIndex       点击按钮的 index
 */

-(void)sAlert:(SAlertView *)sAlert clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface SAlertView : UIView

@property (nonatomic , weak) id<SAlertViewDelegate> delegate;

/**
 *  初始化方法
 *
 *  @param title             标题
 *  @param message           正文
 *  @param cancelButtonTitle 取消
 *  @param otherButtonTitles 确定
 *  @param view              添加alertView的 View
 *  @param delegate          id
 *
 *  @return self
 */
-(instancetype)initWithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles withView:(UIView *) view delegate:(id)delegate;


-(void)show;

@end
