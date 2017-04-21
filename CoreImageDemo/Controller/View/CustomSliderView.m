//
//  CustomSliderView.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/18.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "CustomSliderView.h"
#define kAnimateDuration 1.5

@interface CustomSliderView ()

@property (strong , nonatomic) UISlider * firstSlider;
@property (strong , nonatomic) UISlider * secondSlider;
@property (strong , nonatomic) UISlider * thirdSlider;

@property (strong , nonatomic) UILabel * firstTitleLabel;
@property (strong , nonatomic) UILabel * secondTitleLabel;
@property (strong , nonatomic) UILabel * thirdTitleLabel;



@end
@implementation CustomSliderView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    WS(weakSelf);
    
    //饱和度(默认为1，大于饱和度增加小于1则降低)
    UILabel * firstTitleLabel=[[UILabel alloc]init];
    firstTitleLabel.text=@"饱和度";
    firstTitleLabel.font=[UIFont systemFontOfSize:14];
    _firstTitleLabel = firstTitleLabel;
    [self addSubview:firstTitleLabel];
    
    UISlider * firstSlider = [[UISlider alloc]init];
    firstSlider.minimumValue = 0;
    firstSlider.maximumValue = 2;
    firstSlider.value = 1;
    [firstSlider addTarget:self action:@selector(firstSliderAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:firstSlider];
    _firstSlider = firstSlider;
    
    //亮度(默认为0)
    UILabel * secondTitleLabel=[[UILabel alloc]init];
    secondTitleLabel.text=@"亮度";
    secondTitleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:secondTitleLabel];
    _secondTitleLabel = secondTitleLabel;
    
    UISlider * secondSlider=[[UISlider alloc]init];
    secondSlider.minimumValue=-1;
    secondSlider.maximumValue=1;
    secondSlider.value=0;
    [secondSlider addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:secondSlider];
    _secondSlider = secondSlider;
    
    
    //对比度(默认为1)
    UILabel * threedTitleLabel=[[UILabel alloc]init];
    threedTitleLabel.text=@"对比度";
    threedTitleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:threedTitleLabel];
    _thirdTitleLabel = threedTitleLabel;
    
    UISlider * threedSlider=[[UISlider alloc]init];
    threedSlider.minimumValue=0;
    threedSlider.maximumValue=2;
    threedSlider.value=1;
    [threedSlider addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:threedSlider];
    _thirdSlider = threedSlider;
    
    
    
    [_firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(8);
        make.top.equalTo(weakSelf).offset(8);
        make.height.mas_equalTo(_firstSlider);
        make.width.mas_equalTo(@66);
    }];
    
    [_firstSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_firstTitleLabel.mas_right).offset(8);
        make.centerY.equalTo(_firstTitleLabel.mas_centerY);
        make.right.equalTo(weakSelf).offset(-8);
        
        
    }];
    
    
    [_secondSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstSlider.mas_bottom).offset(8);
        make.leading.equalTo(_firstSlider);
        make.trailing.equalTo(_firstSlider);
    }];
    
    
    [_secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_secondSlider.mas_centerY);
        make.leading.equalTo(_firstTitleLabel);
        make.trailing.equalTo(_firstTitleLabel);
    }];
    
    
    
    [_thirdSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondSlider.mas_bottom).offset(8);
        make.leading.equalTo(_secondSlider);
        make.trailing.equalTo(_secondSlider);
    }];
    
    
    [_thirdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_thirdSlider.mas_centerY);
        make.leading.equalTo(_secondTitleLabel);
        make.trailing.equalTo(_secondTitleLabel);
    }];
    
    _firstTitleLabel.textColor  = [UIColor whiteColor];
    _secondTitleLabel.textColor  = [UIColor whiteColor];
    _thirdTitleLabel.textColor  = [UIColor whiteColor];
}
- (void)firstSliderAction:(UISlider * )sender
{
    if (self.firstblock) {
        self.firstblock(sender.value);
    }
}

- (void)changeBrightness:(UISlider *)sender
{
    if (self.secondblock) {
        self.secondblock(sender.value);
    }
}

- (void)changeContrast:(UISlider * )sender
{
    if (self.thirdlock) {
        self.thirdlock(sender.value);
    }
}

- (void)showView{
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
    } completion:nil];
}

- (void)cancelView{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(0.0, 0.0);
        self.alpha = 0;
    } completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
