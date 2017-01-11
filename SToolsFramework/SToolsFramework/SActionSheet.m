//
//  ShowNumOfSeletedPics.m
//  FileTransfer
//
//  Created by HMC on 16/9/6.
//  Copyright © 2016年 SKing. All rights reserved.
//

#define heightOfBtn 20
// 屏幕宽度
#define  WIDTHOFSCREEN   [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define  HEIGHTOFSCREEN  [UIScreen mainScreen].bounds.size.height

/**
 *  设置颜色
 *
 *  @param r 红
 *  @param g 绿
 *  @param b 蓝
 *  @param a 透明度
 *
 *  @return  UIColor
 */
#define setRGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#import "SActionSheet.h"


@interface SActionSheet()
//view 的背景
@property (strong, nonatomic) UIView * bgView;
//按钮的背景
@property (strong, nonatomic) UIView * btnBGView;


@property (assign, nonatomic) NSInteger arrayCount;


@end

@implementation SActionSheet


-(instancetype)initWithFrame:(CGRect)frame cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray * arrayTitle = [NSMutableArray array];

    //指向参数的指针变量
    va_list btnTitle;
    //初始化上面的变量 otherButtonTitles 是可选参数的第一个参数
    va_start(btnTitle, otherButtonTitles);
    
    if(otherButtonTitles){
    
        //第一个直接放进数组
        [arrayTitle addObject:otherButtonTitles];
        //循环遍历放入数组
            //返回下一个参数,nsstring 为类型, 并指向下一个参数
        while ((otherButtonTitles = va_arg(btnTitle, NSString *))) {
           
            [arrayTitle addObject:otherButtonTitles];
        }

    }
    
    //释放指针变量
    va_end(btnTitle);
    
    
    
    if (self = [super initWithFrame:frame]) {
        
        _arrayCount = arrayTitle.count;
        
        [self addSubview:self.bgView];
        
        //按钮的背景
        _btnBGView = [[UIView alloc]initWithFrame:(CGRect){0,HEIGHTOFSCREEN ,WIDTHOFSCREEN,(arrayTitle.count + 1 ) * 50 + 5 }];
        
        _btnBGView.backgroundColor = setRGBColor(233, 233, 233, 1.0);
        [self addSubview:_btnBGView];
        
        //创建按钮组
        for (int i = 0 ;i <= arrayTitle.count ; i++) {
            
            UIButton * btn = [[UIButton alloc]initWithFrame:(CGRect){0, 50.5 * i,WIDTHOFSCREEN,50}];
            
            
            btn.backgroundColor = [UIColor whiteColor];
            btn.tag = i ;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i != arrayTitle.count) {
                
                [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
                
            }else{
                
                
                btn.frame = (CGRect){0, 50.5 * i + 5,WIDTHOFSCREEN,50};
                [btn setTitle:cancelButtonTitle forState:UIControlStateNormal];
                
            }
            
            [_btnBGView addSubview:btn];
        }
        
        
    }

    return self;
}



-(UIView *)bgView{

    if (!_bgView) {
        
        //_bgView添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        
        _bgView = [[UIView alloc]initWithFrame:(CGRect){0,0,WIDTHOFSCREEN,HEIGHTOFSCREEN - 55}];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [_bgView addGestureRecognizer:tap];
    }
    
    return _bgView;
}


-(void)btnClicked:(UIButton *)btn {
    
    //[self hide];
    self.btnClickedBlock(btn.tag);
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
}

-(void)showInSuperView:(UIView *)view{
    
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.btnBGView.frame = (CGRect){0,HEIGHTOFSCREEN - (self.arrayCount + 1 ) * 50 - 5,WIDTHOFSCREEN,(self.arrayCount + 1 ) * 50 + 5 };
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hide{
    
    self.bgView.hidden = YES;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        self.frame = (CGRect){0,HEIGHTOFSCREEN ,WIDTHOFSCREEN ,0};
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
    
}


@end
