//
//  SliderView.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/14.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "SliderView.h"

#define kAnimateDuration 1.5
#define labelWidth 66
#define labelHeight 30
#define spaceX 8
#define spaceY 8


@interface SliderView ()
{
    int totalHeight;//sliderView的最终高度
}

@end

@implementation SliderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        totalHeight = 0;
        self.frame = frame;
    }
    return self;
}


- (void)setParameters:(NSMutableArray *)parameters{
    _parameters = parameters;
    for (int i = 0 ; i < _parameters.count; i++ ) {
        /*UILabel*/
        CGFloat labelY = i *(labelHeight + spaceY) + spaceY;
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(spaceX, labelY, labelWidth, labelHeight)];
        label.text = _parameters[i];
        if (_labelTextColor) {
            label.textColor = _labelTextColor;
        } else {
            label.textColor = [UIColor whiteColor];
        }
        if (_labelBackColor) {
            label.backgroundColor = _labelBackColor;
        } else {
            label.backgroundColor = [UIColor clearColor];
        }
        [self addSubview:label];
        
        /*UISlider*/
        CGFloat sliderX = spaceX + labelWidth + spaceX;
        CGFloat sliderY =  i *(labelHeight + spaceY) + spaceY;
        UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(sliderX, sliderY, self.frame.size.width - sliderX, 30)];
        slider.maximumValue = self.maximumValue;
        slider.minimumValue = self.minimumValue;
        slider.value = self.defaultValue;
        slider.tag = i;
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        //当前View的最终高度 (30  : UISlider默认高度30)
        [self setHight:self andHight:_parameters.count * 30 + spaceY * (_parameters.count + 1)];
    }
}

#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}

- (void)sliderValueChanged:(UISlider *)sender{
    if (self.sliderBlock) {
        self.sliderBlock(sender.value, sender.tag);
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
