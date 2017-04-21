//
//  FilterScrollView.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/17.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "FilterScrollView.h"

@interface FilterScrollView ()<UIScrollViewDelegate>
{

    UIButton * _filterBtn;

}
@end

@implementation FilterScrollView

- (UIScrollView *)filterScroll{
    if (!_filterScroll) {
        _filterScroll = [[UIScrollView alloc]init];
        _filterScroll.delegate = self;
        _filterScroll.bounces = YES;
        _filterScroll.scrollEnabled = YES;
        _filterScroll.showsHorizontalScrollIndicator = NO;//说平滚动条
        [self addSubview:_filterScroll];
        WS(weakSelf);
        [_filterScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
        }];
    }
    return _filterScroll;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)setFilterNameArr:(NSMutableArray<NSString *> *)filterNameArr{
    _filterNameArr = filterNameArr;
    
    for (int i = 0 ; i < _filterNameArr.count; i++ ) {
        _filterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _filterBtn.layer.cornerRadius = 3;
        _filterBtn.layer.masksToBounds = YES;
        [_filterBtn setBackgroundImage:[UIImage imageNamed:@"whiteAlpha"] forState:UIControlStateNormal];
        [_filterBtn setBackgroundImage:[UIImage imageNamed:@"black"] forState:UIControlStateSelected];
        [_filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_filterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _filterBtn.tag = i;
        [_filterBtn addTarget:self action:@selector(filterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _filterBtn.frame = CGRectMake(i*(scrollHeight), 0, scrollHeight, scrollHeight);
        
        [_filterBtn setTitle:[NSString stringWithFormat:@"%@",_filterNameArr[i]] forState:UIControlStateNormal];
        [self.filterScroll addSubview:_filterBtn];
        
    }
    //滚动范围
    _filterScroll.contentSize = CGSizeMake(scrollHeight * self.filterNameArr.count, 0);
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

- (void)filterBtnClick:(UIButton *)sender
{

    if (self.currentBtn == nil) {
        sender.selected = YES;
        self.currentBtn = sender;
    }else if(self.currentBtn == sender){
        self.currentBtn = sender;
    }else if(self.currentBtn != sender){
        self.currentBtn.selected = NO;
        sender.selected = YES;
        self.currentBtn = sender;
    }
    
    if (self.btnBlock) {
        self.btnBlock(sender.tag);
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
