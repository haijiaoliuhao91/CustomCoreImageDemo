//
//  UIImageView+FilterImage.h
//  CoreImageDemo
//
//  Created by landixing on 2017/4/17.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FilterImage)

+ (UIImage *)initWithImage:(UIImage *)image filterName:(NSString *)filterName;

@end
