//
//  UIImageView+FilterImage.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/17.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "UIImageView+FilterImage.h"

@interface UIImageView ()


@property (nonatomic, strong, readwrite) UIImage *result;


@end

@implementation UIImageView (FilterImage)


+ (UIImage *)initWithImage:(UIImage *)image filterName:(NSString *)filterName{

    
        //将UIImage转换成CIImage(未处理的原始图片: 即 输入源)
        CIImage *inputImage = [[CIImage alloc] initWithImage:image];
        
        //创建滤镜
        CIFilter *filter = [CIFilter filterWithName:filterName
                                      keysAndValues:kCIInputImageKey, inputImage, nil];
        [filter setDefaults];
    
        //渲染并输出CIImage
        CIImage *outputImage = [filter outputImage];

    
        //获取绘制上下文
        CIContext *context = [CIContext contextWithOptions:nil];
        
    
        //创建CGImage句柄
        CGImageRef cgImage = [context createCGImage:outputImage
                                           fromRect:[outputImage extent]];
        
        UIImage * result = [UIImage imageWithCGImage:cgImage];
        
        // 释放CGImage句柄
        CGImageRelease(cgImage);
    
    return result;
}

@end
