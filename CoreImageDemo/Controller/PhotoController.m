//
//  PhotoController.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/13.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "PhotoController.h"
#import "PhotoFilterTool.h"

@interface PhotoController ()<UIScrollViewDelegate>
{
       UIButton * currentBtn;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) UIImage *filterlessImage;

@property (strong , nonatomic) FilterScrollView * filterScroll;

@property (strong , nonatomic) NSMutableArray * filterTitleArr;
@end

@implementation PhotoController
- (NSMutableArray *)filterTitleArr{
    if (!_filterTitleArr) {
        _filterTitleArr = [[NSMutableArray alloc]init];
    }
    return _filterTitleArr;
}

- (FilterScrollView *)filterScroll{
    if (!_filterScroll) {
        _filterScroll = [[FilterScrollView alloc]init];
        _filterScroll.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_filterScroll];
        WS(weakSelf);
        [_filterScroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).offset(8);
            make.right.equalTo(weakSelf.view).offset(-8);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideTop).offset(-20);
            make.height.mas_equalTo(scrollHeight);
        }];
    }
    return _filterScroll;
}


- (void)showFilterName{
    NSArray * filterNames = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    for (NSString * filterName in filterNames) {
        NSLog(@"%@",[CIFilter filterWithName:filterName].attributes);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showFilterName];
    self.filterScroll.filterNameArr = [NSMutableArray arrayWithObjects:@"铬黄",@"褪色",@"怀旧",@"单色",@"黑白",@"冲印",@"色调",@"岁月",@"RGB",@"RGBLinear",@"打磨",@"重影",@"Clamp",@"Vignette",nil];
    WS(weakSelf);
  self.filterScroll.btnBlock = ^(NSInteger tag) {
      switch (tag) {
          case 0:
          {
              
              weakSelf.imgView.image =  [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectChrome" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 1:
          {
              
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectFade" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 2:
          {
              
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectInstant" inputImage:weakSelf.filterlessImage];
          }
              break;
          case 3:
          {
              
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectMono" inputImage:weakSelf.filterlessImage];
          }
              break;
          case 4:
          {
              
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectNoir" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 5:
          {
              
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectProcess" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 6:
          {
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectTonal" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 7:
          {
              weakSelf.imgView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectTransfer" inputImage:weakSelf.filterlessImage];
              
          }
              break;
              
          case 8:
          {
              weakSelf.imgView.image =    [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CILinearToSRGBToneCurve" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 9:
          {
              weakSelf.imgView.image =    [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CISRGBToneCurveToLinear" inputImage:weakSelf.filterlessImage];
              
          }
              break;
          case 10:
          {
              weakSelf.imgView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIConvolution3X3" sourceImage:weakSelf.filterlessImage];
          }
              break;
          case 11:
          {
              weakSelf.imgView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIConvolution5X5" sourceImage:weakSelf.filterlessImage];
          }
              break;
          case 12:
          {
              weakSelf.imgView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIColorClamp" sourceImage:weakSelf.filterlessImage];
          }
              break;
          case 13:
          {
              weakSelf.imgView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIVignetteEffect" sourceImage:weakSelf.filterlessImage];
          }
              break;
              
              
              
              
          default:
              break;
      }

  };
    self.filterlessImage = [UIImage imageNamed:@"ivy_chen"];
    self.imgView.image = self.filterlessImage;
    
    
}
//@"CITemperatureAndTint"
//@"CIToneCurve"
//"CIColorClamp"

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
