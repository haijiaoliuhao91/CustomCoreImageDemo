//
//  PhotoFilterTool.h
//  CoreImageDemo
//
//  Created by landixing on 2017/4/13.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PhotoFilterTool : NSObject

+ (PhotoFilterTool *)sharePhotoFilter;
@property (strong , nonatomic)     CIFilter * filter;

- (UIImage * )outputImageWithFilterName:(NSString *)filterName inputImage:(UIImage *)inputImage;


- (UIImage *)outputImageWithConvolution:(NSString *)filterName sourceImage:(UIImage *)sourceImage;


@end
