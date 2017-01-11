//
//  SButton.m
//  SButton
//
//  Created by HMC on 2017/1/5.
//  Copyright © 2017年 HMC. All rights reserved.
//

#import "SButton.h"

@interface SButton()

/** 粒子发射器
 */
@property (nonatomic, strong)  CAEmitterLayer *caEmitterLayer;

/** 是否点击按钮时候 展示粒子动画
 */
@property BOOL isShowAnimation;

@end

@implementation SButton


- (instancetype)initWithFrame:(CGRect)frame bullet:(UIImage * )bulletImg  isShowAnimation:(BOOL)isShowAnimation{
    
    if (self = [super initWithFrame:frame]) {
        
        self.isShowAnimation = isShowAnimation;
        [self setupwithBollet:bulletImg];
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    [self animation];
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    //设置粒子发射的起点
    if (self.imageView) {
        
        self.caEmitterLayer.position = self.imageView.center;
    }else{
        
        self.caEmitterLayer.position = self.titleLabel.center;
    }
}

- (void)setupwithBollet:(UIImage *)bullet {
    
    //粒子有关
    //粒子使用CAEmitterCell初始化
    CAEmitterCell *emitterCell   = [CAEmitterCell emitterCell];
    
    //名字(用于设置喷射个数)
    emitterCell.name             = @"emitterCell";
    
    //生命周期和生命周期范围
    emitterCell.lifetime         = 0.4;
    emitterCell.lifetimeRange    = 0.3;
    
    //发射速度和速度的范围
    emitterCell.velocity         = 100.00;
    emitterCell.velocityRange    = 20.00;
    
    //缩放比例和缩放比例的范围
    emitterCell.scale            = 0.1;     //10%
    emitterCell.scaleRange       = 0.02;
    
    //透明度速度和透明度改变范围
    emitterCell.alphaSpeed       = -1.0;
    emitterCell.alphaRange       = 0.10;
    
    //粒子的图片
    emitterCell.contents         = (id)bullet.CGImage;
    
    
    //发射器有关
    //初始化
    CAEmitterLayer *emitterLayer        = [CAEmitterLayer layer];
    //粒子发射器的 名称
    emitterLayer.name                   = @"emitterLayer";
    //发射粒子 ,可以不只是一个类型
    emitterLayer.emitterCells           = @[emitterCell];
    //z 轴的相对坐标 设置为-1
    emitterLayer.zPosition              = -1;
    
    //发射圆形
    emitterLayer.emitterShape           = kCAEmitterLayerCircle;
    //发射的模式
    emitterLayer.emitterMode            = kCAEmitterLayerOutline;
    //渲染模式
    emitterLayer.renderMode             = kCAEmitterLayerOldestFirst;
    //是否 cut
    emitterLayer.masksToBounds          = NO;
    
    //添加layer
    [self.layer addSublayer:emitterLayer];
    
    self.caEmitterLayer = emitterLayer;
}

- (void)animation {
    
    //关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        
        keyAnimation.values = @[@1.4 ,@0.9, @1.0,@1.3,@1.0];
        keyAnimation.duration = 0.4;
        
        if (self.isShowAnimation) {
            
            [self startShoot];
        }
    }else
    {
        keyAnimation.values = @[@0.7, @1.0];
        keyAnimation.duration = 0.3;
    }
    // 动画模式
    keyAnimation.calculationMode = kCAAnimationCubic;
    [self.imageView.layer addAnimation:keyAnimation forKey:@"transform.scale"];
}


- (void)startShoot{
    
    // 每秒喷射的500个
    [self.caEmitterLayer setValue:@300 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    // 开始时间 : 现在立即开始
    self.caEmitterLayer.beginTime = CACurrentMediaTime();
    // 0.1秒后停止,相当于立即停止
    [self performSelector:@selector(stopShoot) withObject:nil afterDelay:0.1];
    
}


- (void)stopShoot {
    
    [self.caEmitterLayer setValue:@0 forKeyPath:@"emitterCells.emitterCell.birthRate"];
}


@end
