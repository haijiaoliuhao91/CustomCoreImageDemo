//
//  PhotoFilterTool.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/13.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "PhotoFilterTool.h"

#import <CoreImage/CoreImage.h>


@interface PhotoFilterTool ()
{
    CIContext * context;
    CIImage * cimage;
}

@end

@implementation PhotoFilterTool

+ (PhotoFilterTool *)sharePhotoFilter{
    static PhotoFilterTool * filterTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filterTool = [[PhotoFilterTool alloc]init];
    });
    return filterTool;
}

- (UIImage * )outputImageWithFilterName:(NSString *)filterName inputImage:(UIImage *)inputImage{
    //需要渲染处理的图片
    CIImage * inputImge = [[CIImage alloc]initWithImage:inputImage];
    
    //滤镜
    self.filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey,inputImge, nil];
    // 已有的值不改变, 其他的设为默认值
    [self.filter setDefaults];
    
    //渲染后的图片
    CIImage * outputImage = [self.filter outputImage];
    
    //绘制上下文
    context = [CIContext contextWithOptions:nil];
    
    //创建CGImageRef
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    
    //获取图片
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return image;
}



- (UIImage *)outputImageWithConvolution:(NSString *)filterName sourceImage:(UIImage *)sourceImage{
    
    // 1. 获取source图片
    //    UIImage *inputOrigin = [UIImage imageNamed:@"ivy_chen"];
    // 2. 创建滤镜
    self.filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, cimage, nil];
    // 设置相关参数
    {
        CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
        [self.filter setValue:inputImage forKey:kCIInputImageKey];
       
        if ([filterName isEqualToString:@"CIConvolution3X3"]) {
            [self Convolution3x3];
        } else  if ([filterName isEqualToString:@"CIConvolution5X5"]){
            [self Convolution5x5];
        }else if ([filterName isEqualToString:@"CIColorClamp"]){
        
            [self ColorClamp];
        }
     
    }
    //4. 渲染输出
    CIImage * outputImage = [self.filter outputImage];
    
    //5. 绘制上下文
    context = [CIContext contextWithOptions:nil];
    
    //6. 创建输出
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    //释放
    CGImageRelease(imageRef);
    return image;

}

- (void)Convolution3x3
{
    CGFloat weights[] = {0,-1,0,
        -1,5,-1,
        0,-1,0};// 进行打磨处理 使用卷积5X5矩阵的话, 这个可以实现重影效果"(3X3也可以,效果不好看)"
    
  CIVector * inputWeights  = [CIVector vectorWithValues:weights count:9];// count 必须与输入的一致
    [self.filter setValue:inputWeights forKey:kCIInputWeightsKey];
    [self.filter setValue:@0 forKey:kCIInputBiasKey];
}

- (void)Convolution5x5{
    CGFloat weights[] = {0.1,0,0,0,0,
        0,0,0,0,0,
        0,0,0,0,0,
        0,0,0,0,0.5,
        0,0,0,0,1.0};//重影效果
    CIVector * inputWeights  = [CIVector vectorWithValues:weights count:25];// count 必须与输入的一致
    [self.filter setValue:inputWeights forKey:kCIInputWeightsKey];
    [self.filter setValue:@0 forKey:kCIInputBiasKey];
}


- (void)ColorClamp{
    CGFloat min[] = {0, 0, 0.5, 0};
    CGFloat max[] = {1, 1, 0.5, 1};
    CIVector * maxComponents = [CIVector vectorWithValues:max count:4];// count 必须与输入的一致
    CIVector * minComponents = [CIVector vectorWithValues:min count:4];// count 必须与输入的一致
    
    [self.filter setValue:maxComponents forKey:@"inputMaxComponents"];//inputMaxComponents
    [self.filter setValue:minComponents forKey:@"inputMinComponents"];//
}
@end
