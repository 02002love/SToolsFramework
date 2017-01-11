//
//  FlushLab.m
//  AnimatedMaskLabel
//
//  Created by HMC on 2016/12/6.
//  Copyright © 2016年 Smile. All rights reserved.
//

#import "SLabel.h"

@interface SLabel()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation SLabel


-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font{


    if (self = [super initWithFrame:frame]) {
        
        self.text = text;
        self.textColor = textColor;
        self.font = font;
        
    }
    
    return self;
    
}

-(CAGradientLayer *)gradientLayer{
    
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.locations = @[@0.25, @0.5, @0.75];
        _gradientLayer.colors = @[(id)self.textColor.CGColor,
                                  (id)[UIColor whiteColor].CGColor,
                                  (id)self.textColor.CGColor];
        _gradientLayer.startPoint = CGPointMake(0.0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.5);
        
    }
    return _gradientLayer;
}



-(void)drawRect:(CGRect)rect{
    
}


-(void)setFlushStyle:(BOOL) isFlush{
    
    self.gradientLayer.frame = CGRectMake( 0,0,self.frame.size.width,self.frame.size.height);
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentLeft;
    
    //开始
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0);
    
    [self.text drawInRect:self.bounds withAttributes:@{NSParagraphStyleAttributeName:style , NSFontAttributeName: self.font}];
    
    //获取当前
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束
    UIGraphicsEndImageContext();
    
    CALayer * maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    maskLayer.frame = CGRectOffset((CGRect){0,0,self.frame.size}, 0, 0);
    maskLayer.contents = (id)image.CGImage;
    
    self.gradientLayer.mask = maskLayer;
    
    if (isFlush)
        
        [self.layer addSublayer: self.gradientLayer];
    else
        [self.layer addSublayer:maskLayer];
    
    CABasicAnimation * basicAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    basicAnim.fromValue = @[@0.0, @0.0, @0.25];
    basicAnim.toValue = @[@0.75, @1.0, @1.0];
    basicAnim.duration = 2.8;
    basicAnim.repeatCount = CGFLOAT_MAX;
    basicAnim.removedOnCompletion = NO;
    [self.gradientLayer addAnimation:basicAnim forKey:nil];
    
}

@end
