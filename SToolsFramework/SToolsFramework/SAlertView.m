//
//  myAlert.m
//  customAlert
//
//  Created by HMC on 16/7/6.
//  Copyright © 2016年 SKing. All rights reserved.
//

#import "SAlertView.h"
#import "UIView+AnimationProperty.h"
#import "Header.h"
#import "UIView+SetRect.h"

#define titleLabelHeight 40.f
#define spaceOfButton 10.f
#define btnHeight 25.f

@interface SAlertView()

@property (nonatomic ,weak ) UILabel * titleLabel;
@property (nonatomic ,weak ) UILabel * messageLabel;
@property (nonatomic ,weak ) UIButton * cancelBtn;
@property (nonatomic ,weak ) UIButton * otherBtn;

@property (nonatomic ,assign)CGFloat alertTotalHeight;
@property (nonatomic ,assign)NSInteger numberOfButton;

//添加在指定的 View 上
@property (nonatomic ,weak ) UIView * targetView;
@property (nonatomic ,weak ) UIControl * backView;

@end

@implementation SAlertView


-(instancetype)initWithTitle:( NSString *)title message:( NSString *)message cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles withView:(UIView *)view delegate:(id)delegate{
    
    CGRect frameOfAlert = CGRectMake(0, 0, 0, 0);
    self.delegate = delegate;
    
    if (self = [super initWithFrame:frameOfAlert]) {
        
        if (title.length) {
            
            UILabel * tmptitleLabel = [UILabel new];
            tmptitleLabel.text = title;
            tmptitleLabel.textAlignment = NSTextAlignmentCenter;
            tmptitleLabel.textColor = [UIColor whiteColor];
            tmptitleLabel.font = [UIFont systemFontOfSize:18];
            //[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:18.f];
            self.titleLabel = tmptitleLabel;
            [self addSubview:tmptitleLabel];
            
        }
        
        if (message.length) {
            
            UILabel * tmpmessageLabel = [UILabel new];
            tmpmessageLabel = tmpmessageLabel;
            tmpmessageLabel.text = message;
            tmpmessageLabel.textColor = [UIColor whiteColor];
            tmpmessageLabel.numberOfLines = 0;
            tmpmessageLabel.textAlignment = NSTextAlignmentCenter;
            tmpmessageLabel.font = [UIFont systemFontOfSize:16];
            //[UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:16.f];
            [self addSubview:tmpmessageLabel];
            self.messageLabel = tmpmessageLabel;
        }
        
        if (cancelButtonTitle.length) {
            
            self.numberOfButton ++;
            UIButton * tmpCancelBtn = [UIButton new];
            [tmpCancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            tmpCancelBtn.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:.85f];
            tmpCancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            //[UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:14.f];
            [tmpCancelBtn addTarget:self action:@selector(ClickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            tmpCancelBtn.tag = 0;
            self.cancelBtn = tmpCancelBtn;
            
            [self addSubview:tmpCancelBtn];
            
        }
        
        if (otherButtonTitles.length) {
            
            self.numberOfButton ++;
            UIButton * tmpOtherBtn = [UIButton new];
            [tmpOtherBtn setTitle:otherButtonTitles forState:UIControlStateNormal];
            tmpOtherBtn.backgroundColor = [@"删除" isEqualToString: otherButtonTitles ] || [@"Delete" isEqualToString: otherButtonTitles ] || [@"DELETE" isEqualToString: otherButtonTitles ] || [@"delete" isEqualToString: otherButtonTitles ]|| [@"刪除" isEqualToString: otherButtonTitles ]  ? [[UIColor redColor] colorWithAlphaComponent:.85f] : [[UIColor grayColor]colorWithAlphaComponent:.85f];
            tmpOtherBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            //[UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:14.f];
            [tmpOtherBtn addTarget:self action:@selector(ClickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            tmpOtherBtn.tag = self.cancelBtn.tag == 0 ? 1 : 0;
            self.otherBtn = tmpOtherBtn;
            
            [self addSubview:tmpOtherBtn];
        }
        
        self.targetView = view;
    }
    return self;
    
}

//引用分类的写法
//-(void)layoutSubviews{
//    
//    [super layoutSubviews];
//    
//    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
//    self.width = ScreenWidth - 100;
//    
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = titleLabelHeight;
//    self.titleLabel.x = 0;
//    self.titleLabel.y = 0;
//    
//    self.messageLabel.width = self.width - 4;
//    [self.messageLabel sizeToFit];
//    self.messageLabel.x = 4;
//    self.messageLabel.y = titleLabelHeight;
//    self.messageLabel.centerX = self.width * 0.5;
//    
//    
//    CGFloat buttonWidth = self.numberOfButton == 1? self.width - 2 * spaceOfButton : (self.width - 3 * spaceOfButton) * 0.5;
//    
//    self.cancelBtn.width = buttonWidth;
//    self.cancelBtn.height = btnHeight;
//    self.cancelBtn.x = spaceOfButton;
//    self.cancelBtn.y = titleLabelHeight + self.messageLabel.height + 20;
//    
//    self.otherBtn.width = buttonWidth;
//    self.otherBtn.height = btnHeight;
//    self.otherBtn.x =self.numberOfButton == 1? spaceOfButton : spaceOfButton * 2 + buttonWidth;
//    self.otherBtn.y = titleLabelHeight + self.messageLabel.height + 20;
//    
//    CGFloat eage = self.cancelBtn==nil ? self.otherBtn.y : self.cancelBtn.y;
//    self.height = 30 + eage;
//    self.center = (CGPoint){ScreenWidth *0.5, ScreenHeight *0.5};
//    
//    
//}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5f];
    
    CGRect newFrame = self.frame;
    newFrame.size.width = ScreenWidth - 100;
    self.frame = newFrame;
    
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, titleLabelHeight);
    
    self.messageLabel.frame = CGRectMake(4, titleLabelHeight, self.frame.size.width - 4, self.messageLabel.frame.size.height);
    [self.messageLabel sizeToFit];
    self.messageLabel.center =  CGPointMake(self.frame.size.width * 0.5, self.messageLabel.center.y);
    
    CGFloat buttonWidth = self.numberOfButton == 1? self.frame.size.width - 2 * spaceOfButton : (self.frame.size.width - 3 * spaceOfButton) * 0.5;
    
    self.cancelBtn.frame = CGRectMake(spaceOfButton, titleLabelHeight + self.messageLabel.frame.size.height + 20, buttonWidth, btnHeight);
    
    self.otherBtn.frame = CGRectMake(self.numberOfButton == 1? spaceOfButton : spaceOfButton * 2 + buttonWidth, titleLabelHeight + self.messageLabel.frame.size.height + 20, buttonWidth, btnHeight);
    
    CGFloat eage = self.cancelBtn==nil ? self.otherBtn.frame.origin.y : self.cancelBtn.frame.origin.y;
    
    CGRect newFrame1 = self.frame;
    newFrame1.size.height = eage + 30;
    self.frame = newFrame1;
    
    self.center = (CGPoint){ScreenWidth *0.5, ScreenHeight *0.5};
    
    
}

-(void)show{
    
    UIControl * backgroundView = [[UIControl alloc] initWithFrame:(CGRect){0,0,ScreenWidth,ScreenHeight}];
    self.backView = backgroundView;
    [self.targetView addSubview:backgroundView];
    [backgroundView addSubview:self];
    [self showAnimation];
    
}

-(void)showAnimation{
    
    self.alpha = 0.f;
    //self.scale = 1.5f;
    self.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    
    [UIView animateWithDuration:1.0f delay:0.f usingSpringWithDamping:1 initialSpringVelocity:0 options:0
                     animations:^{
                         self.alpha = 1.f;
//                         self.scale = 1.f;
                         self.transform = CGAffineTransformMakeScale(1.f, 1.f);
                     } completion:^(BOOL finished) {
                         
                     }];
}

-(void)hideAnimation{
    
    [UIView animateWithDuration:1.0f delay:0.f usingSpringWithDamping:1 initialSpringVelocity:0 options:0
                     animations:^{
                         self.alpha = 0.f;
//                         self.scale = .5f;
                         self.transform = CGAffineTransformMakeScale(.5f, .5f);
                     } completion:^(BOOL finished){
                         
                         [self.backView removeFromSuperview];
                         [self removeFromSuperview];
                         
                     }];
}

-(void)ClickedCancelBtn:(UIButton *)btn{

    [self hideAnimation];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sAlert:clickedButtonAtIndex:)]) {
        
        [self.delegate sAlert:self clickedButtonAtIndex:btn.tag];
    
    }
    
    
}



@end
