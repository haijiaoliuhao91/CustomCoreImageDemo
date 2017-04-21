//
//  FilterScrollView.h
//  CoreImageDemo
//
//  Created by landixing on 2017/4/17.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterScrollView : UIView

@property (strong , nonatomic) UIScrollView * filterScroll;

@property (strong , nonatomic) UIButton * currentBtn;


@property (strong , nonatomic) NSMutableArray<NSString *> * filterNameArr;

- (instancetype)initWithFrame:(CGRect)frame filterName:(NSMutableArray * )filterName;
@property (copy, nonatomic) void(^btnBlock)(NSInteger tag);


- (void)showView;
- (void)cancelView;
@end
