//
//  SliderView.h
//  CoreImageDemo
//
//  Created by landixing on 2017/4/14.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderView : UIView

@property (assign, nonatomic) CGFloat maximumValue;
@property (assign, nonatomic) CGFloat minimumValue;
@property (assign, nonatomic) CGFloat defaultValue;

/*label颜色*/
@property (strong , nonatomic) UIColor * labelTextColor;

/*label背景颜色*/
@property (strong , nonatomic) UIColor * labelBackColor;

@property (copy, nonatomic) void(^sliderBlock)(float changeValue ,NSInteger sliderTag);
@property (strong , nonatomic) NSMutableArray * titlesArray;//参数名
@property (strong , nonatomic) NSMutableArray * parameters; //Slider数组
- (void)showView;
- (void)cancelView;

@end
