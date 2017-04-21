//
//  ViewController.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/12.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIScrollViewDelegate>
{
    CIFilter * filter;//滤镜
    CIContext * context;//上下文
    UIButton * currentBtn;
    CIImage  * ciImage;

    float firstValue;
    float secondValue;
    float threedValue;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) UIImage *filterlessImage;

@property (strong , nonatomic) FilterScrollView * filterScroll;

@property (strong , nonatomic) UIButton * filterBtn;
@property (strong , nonatomic) NSMutableArray * filterTitleArr;
@property (strong , nonatomic) SliderView * sliderView;

@end

@implementation ViewController


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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterlessImage = [UIImage imageNamed:@"ivy_chen"];
    self.imgView.image = self.filterlessImage;
    
   NSMutableArray * titleArr = [NSMutableArray arrayWithObjects:@"打磨",@"重影",@"Clamp",@"Controls",nil];
    
    self.filterScroll.filterNameArr = titleArr;
    WS(weakSelf);
    self.filterScroll.btnBlock = ^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
            
                weakSelf.imgView.image = [UIImageView initWithImage:weakSelf.filterlessImage filterName:@"CIConvolution3X3"];
            }
                break;
            case 1:
            {
                weakSelf.imgView.image = [UIImageView initWithImage:weakSelf.filterlessImage filterName:@"CIConvolution5X5"];
            }
                break;
            case 2:
            {
                weakSelf.imgView.image = [UIImageView initWithImage:weakSelf.filterlessImage filterName:@"CIColorClamp"];
            }
                break;
            case 3:
            {
                weakSelf.imgView.image = [UIImageView initWithImage:weakSelf.filterlessImage filterName:@"CIVignetteEffect"];
            }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:self.filterScroll];
 
    
    _sliderView = [[SliderView alloc]initWithFrame:CGRectMake(10, 94, self.view.frame.size.width - 20, 0)];
    //slider数组
    self.sliderView.parameters = [NSMutableArray arrayWithObjects:@"美白",@"抛光", nil];

    self.sliderView.sliderBlock = ^(float changeValue, NSInteger sliderTag) {
        switch (sliderTag) {
            case 0:
            {
                [filter setValue:[NSNumber numberWithFloat:changeValue] forKey:@"inputSaturation"];//设置滤镜参数
            }
                break;
            case 1:
            {
                [filter setValue:[NSNumber numberWithFloat:changeValue] forKey:@"inputBrightness"];//亮度
            }
                break;
            case 2:
            {
                [filter setValue:[NSNumber numberWithFloat:changeValue] forKey:@"inputContrast"];//对比度
            }
                break;
            default:
                break;
        }

    };
    [self.view addSubview:self.sliderView];
    [self.sliderView showView];
    
    
}





- (UIImage *)outputImageWithConvolution:(NSString *)filterName sourceImage:(UIImage *)sourceImage isParameters:(BOOL)hasValue{
    
    // 1. 获取source图片
    //    UIImage *inputOrigin = [UIImage imageNamed:@"ivy_chen"];
    // 2. 创建滤镜
     filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, sourceImage, nil];
    // 设置相关参数
    {
        CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        
        CGFloat min[] = {0, 0, 0.5, 0};
        CGFloat max[] = {1, 1, 0.5, 1};
        CIVector * maxComponents = [CIVector vectorWithValues:max count:4];// count 必须与输入的一致
        CIVector * minComponents = [CIVector vectorWithValues:min count:4];// count 必须与输入的一致
        
        [filter setValue:maxComponents forKey:@"inputIntensity"];//inputMaxComponents
        [filter setValue:minComponents forKey:@"inputRadius"];//
        
    }
    //4. 渲染输出
    CIImage * outputImage = [filter outputImage];
    
    //5. 绘制上下文
    context = [CIContext contextWithOptions:nil];
    
    //6. 创建输出
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    //释放
    CGImageRelease(imageRef);
    return image;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
