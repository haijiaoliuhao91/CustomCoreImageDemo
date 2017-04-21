//
//  PickerController.m
//  CoreImageDemo
//
//  Created by landixing on 2017/4/14.
//  Copyright © 2017年 WJQ. All rights reserved.
//

#import "PickerController.h"
#import "CustomSliderView.h"

@interface PickerController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *_pickerControll;//系统照片选择控制器
    CIContext   * _context;//Core Image上下文
    CIImage     * _inputImage;//我们要编辑的图像
    CIImage     * _outputImage;//处理后的图像
    CIFilter    * _colorControlsFilter;//色彩滤镜
    UIImage * selectedImage;
}
@property (strong, nonatomic) IBOutlet UIImageView *showImageView;//图片显示控件
@property (strong, nonatomic) CustomSliderView * sliderView;

@property (strong, nonatomic) IBOutlet UIButton *editorBtn;
@property (strong, nonatomic) CIFilter    * colorControlsFilter;//色彩滤镜



@end

@implementation PickerController


- (CustomSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[CustomSliderView alloc]init];
        WS(weakSelf);
        //饱和度
        _sliderView.firstblock = ^(float firstValue) {
            [weakSelf.colorControlsFilter setValue:[NSNumber numberWithFloat:firstValue] forKey:@"inputSaturation"];//设置滤镜参数
            [weakSelf setImage];
        };
        //亮度
        _sliderView.secondblock = ^(float secondValue) {
            [weakSelf.colorControlsFilter setValue:[NSNumber numberWithFloat:secondValue] forKey:@"inputBrightness"];
            [weakSelf setImage];
        };
        //对比度
        _sliderView.thirdlock = ^(float thirdValue) {
            [weakSelf.colorControlsFilter setValue:[NSNumber numberWithFloat:thirdValue] forKey:@"inputContrast"];
            [weakSelf setImage];
        };

    }
    return _sliderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册1";
    [self.view addSubview:self.sliderView];    
    
    /*create pickerController */
    _pickerControll = [[UIImagePickerController alloc]init];
    _pickerControll.delegate = self;
    
    
    
    [self setupEditBtn];
    [self setupNavi];

    
    
    /*初始化CIContext*/
    _context=[CIContext contextWithOptions:nil];//使用GPU渲染，推荐,但注意GPU的CIContext无法跨应用访问，例如直接在UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染，所以推荐现在完成方法中保存图像，然后在主程序中调用
//        EAGLContext *eaglContext=[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES1];
//        _context=[CIContext contextWithEAGLContext:eaglContext];//OpenGL优化过的图像上下文
    
    //取得滤镜
    _colorControlsFilter=[CIFilter filterWithName:@"CIColorControls"];


}

- (void)setupEditBtn
{
    [self.editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editorBtn setTitle:@"取消" forState:UIControlStateSelected];
    self.editorBtn.hidden = YES;
    
}

- (void)setupNavi{
    //上方导航按钮
    self.navigationItem.title=@"Enhance";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openPhoto:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savePhoto:)];
}


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
- (void)editorBtnClick:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        self.showImageView.image = selectedImage;
        [_sliderView cancelView];

    }else{
        sender.selected = YES;
        WS(weakSelf);
        [_sliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).offset(-10);
            make.left.equalTo(weakSelf.view).offset(20);
            make.right.equalTo(weakSelf.view).offset(-20);
            make.height.mas_equalTo(122);
        }];
        
        [_sliderView showView];
    }
}

#pragma mark 图片选择器选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil
     ];
    
    //取得选择的图片
     selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectedImage != nil) {
        self.editorBtn.hidden = NO;
        [self.editorBtn addTarget:self action:@selector(editorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.showImageView.image = selectedImage;

    }
    
    //初始化CIImage
    _inputImage = [CIImage imageWithCGImage:selectedImage.CGImage];
    [_colorControlsFilter setValue:_inputImage forKey:@"inputImage"];//设置滤镜的输入图片
    
    
}

#pragma mark 将输出图片设置到UIImageView
-(void)setImage{
    CIImage *outputImage= [_colorControlsFilter outputImage];//取得输出图像
    CGImageRef temp=[_context createCGImage:outputImage fromRect:[outputImage extent]];
    self.showImageView.image=[UIImage imageWithCGImage:temp];//转化为CGImage显示在界面中
    
    CGImageRelease(temp);//释放CGImage对象
}

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
