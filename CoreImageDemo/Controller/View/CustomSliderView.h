//
//  CustomSliderView.h
//  CoreImageDemo
//
//  Created by landixing on 2017/4/18.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSliderView : UIView
@property (assign, nonatomic) float firstValue;

@property (assign, nonatomic) float secondValue;

@property (assign, nonatomic) float thirdValue;

@property (copy , nonatomic) void(^firstblock)(float firstValue);
@property (copy , nonatomic) void(^secondblock)(float secondValue);
@property (copy , nonatomic) void(^thirdlock)(float thirdValue);



- (void)showView;
- (void)cancelView;
@end
