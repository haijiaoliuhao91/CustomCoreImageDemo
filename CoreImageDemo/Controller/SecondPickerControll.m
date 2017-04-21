//
//  SecondPickerControll.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/18.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "SecondPickerControll.h"

@interface SecondPickerControll ()<UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *_pickerControll;//系统照片选择控制器
    UIButton * currentBtn;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *showImageView;
@property (nonatomic, strong) UIImage *filterlessImage;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;


@property (strong , nonatomic) FilterScrollView * filterScroll;

@property (strong , nonatomic) NSMutableArray * filterTitleArr;

@end

@implementation SecondPickerControll
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
    
    self.editBtn.hidden = YES;
    
    _pickerControll = [[UIImagePickerController alloc]init];
    _pickerControll.delegate = self;
    
    //上方导航按钮
    self.navigationItem.title=@"Enhance";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePhoto:)];
    WS(weakSelf);
    self.filterScroll.btnBlock = ^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
                
                weakSelf.showImageView.image =  [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectChrome" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 1:
            {
                
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectFade" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 2:
            {
                
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectInstant" inputImage:weakSelf.filterlessImage];
            }
                break;
            case 3:
            {
                
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectMono" inputImage:weakSelf.filterlessImage];
            }
                break;
            case 4:
            {
                
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectNoir" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 5:
            {
                
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectProcess" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 6:
            {
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectTonal" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 7:
            {
                weakSelf.showImageView.image =   [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CIPhotoEffectTransfer" inputImage:weakSelf.filterlessImage];
                
            }
                break;
                
            case 8:
            {
                weakSelf.showImageView.image =    [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CILinearToSRGBToneCurve" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 9:
            {
                weakSelf.showImageView.image =    [[PhotoFilterTool sharePhotoFilter]outputImageWithFilterName:@"CISRGBToneCurveToLinear" inputImage:weakSelf.filterlessImage];
                
            }
                break;
            case 10:
            {
                weakSelf.showImageView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIConvolution3X3" sourceImage:weakSelf.filterlessImage];
            }
                break;
            case 11:
            {
                weakSelf.showImageView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIConvolution5X5" sourceImage:weakSelf.filterlessImage];
            }
                break;
            case 12:
            {
                weakSelf.showImageView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIColorClamp" sourceImage:weakSelf.filterlessImage];
            }
                break;
            case 13:
            {
                weakSelf.showImageView.image = [[PhotoFilterTool sharePhotoFilter]outputImageWithConvolution:@"CIVignetteEffect" sourceImage:weakSelf.filterlessImage];
            }
                break;
                
                
                
                
            default:
                break;
        }
        
    };
    //    self.filterlessImage = [UIImage imageNamed:@"ivy_chen"];
    //    self.showImageView.image = self.filterlessImage;
    
    
}
//@"CITemperatureAndTint"
//@"CIToneCurve"
//"CIColorClamp"





#pragma mark 打开图片选择器
-(void)openPhoto:(UIBarButtonItem *)btn{
    //打开图片选择器
    [self presentViewController:_pickerControll animated:YES completion:nil];
}
#pragma mark 保存图片
-(void)savePhoto:(UIBarButtonItem *)btn{
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(self.showImageView.image, nil, nil, nil);
    UIAlertController * alertContr = [UIAlertController alertControllerWithTitle:@"Sytem Info" message:@"Save Success!" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertContr addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertContr animated:YES completion:nil];
    
}

#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil
     ];
    
    //取得选择的图片
    self.filterlessImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.filterlessImage != nil) {
        self.showImageView.image = self.filterlessImage;
        self.editBtn.hidden = NO;
       
    }
    
}

- (IBAction)change:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        self.showImageView.image = self.filterlessImage;
        [_filterScroll cancelView];
        
    }else{
        sender.selected = YES;
        [sender setTitle:@"取消" forState:UIControlStateSelected];
        [self.view addSubview:self.filterScroll];
        WS(weakSelf);
        [_filterScroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view).offset(8);
            make.right.equalTo(weakSelf.view).offset(-8);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideTop).offset(-20);
            make.height.mas_equalTo(scrollHeight);
        }];
        [self.filterScroll showView];
    }
    
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
