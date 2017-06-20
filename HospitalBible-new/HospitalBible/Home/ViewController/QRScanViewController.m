//
//  QRScanViewController.m
//  EIntegrate
//
//  Created by 张东伟 on 16/12/6.
//  Copyright © 2016年 ZDW All rights reserved.
//

#import "QRScanViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "LGAlertViewExtension.h"
@interface QRScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIView *baseLineView;
@property (nonatomic, assign) BOOL lightOn;
@property (nonatomic, assign) BOOL cameraAuthorized;
@property (nonatomic, strong) UILabel *loadingLabel;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *line;

@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (strong, nonatomic) NSString *jumpString;


@property (nonatomic) BOOL firstAlert;
@end

@implementation QRScanViewController

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor blackColor];
    }
    return _backView;
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backImageView.image = [UIImage imageNamed:@"scan_cover"];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}


- (UIView *)baseLineView
{
    //161
    //44
    //288
    if (!_baseLineView) {
        _baseLineView = [[UIView alloc] initWithFrame:CGRectMake(38 * KWidth_Scale, 158 * KWidth_Scale, 300 * KWidth_Scale, 300 * KWidth_Scale)];
        [self.backImageView addSubview:_baseLineView];
        _baseLineView.clipsToBounds = YES;

        _line = [[UIImageView alloc] initWithFrame:CGRectMake(0 * KWidth_Scale, -74 * KWidth_Scale, 300 * KWidth_Scale, 74 * KWidth_Scale)];
        _line.image = [UIImage imageNamed:@"scan_translucent"];
        [_baseLineView addSubview:_line];

        [self setupTime];
    }
    return _baseLineView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cameraAuthorized = YES;
    //    self.naviBarVisible = NO;
    // self.navigationController.navigationBar.hidden = YES;
    [self configView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];

    self.view.backgroundColor = [UIColor redColor];
}

- (void)ApplicationDidEnterBackground
{
    if (self.lightOn) {
        [self turnOffLed];
    }
    self.lightOn = !self.lightOn;
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
    [self.session stopRunning];
    self.session = nil;
    self.cameraAuthorized = NO;
    [self.baseLineView removeFromSuperview];
    self.baseLineView = nil;
}

- (void)ApplicationWillEnterForeground
{
    [self configCamera];
    self.baseLineView.backgroundColor = [UIColor clearColor];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self configCamera];
    self.baseLineView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.lightOn) {
        [self turnOffLed];
    }
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.lightOn = !self.lightOn;
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
    [self.session stopRunning];
    self.session = nil;
    self.cameraAuthorized = NO;
    [self.baseLineView removeFromSuperview];
    self.baseLineView = nil;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - configView
//设置界面
- (void)configView
{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 33 * KWidth_Scale, SCREEN_WIDTH, 25 * KWidth_Scale)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"二维码扫描";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.backImageView addSubview:titleLabel];

    self.backImageView.hidden = NO;
    self.backView.backgroundColor = [UIColor blackColor];
    //背景view
    [self.view insertSubview:_backView atIndex:0];
    //扫描框
    [self.view addSubview:_backImageView];

    //LED灯光按钮
    UIButton *LEDlightBtn = [[UIButton alloc] initWithFrame:CGRectMake(340 * KWidth_Scale, 34 * KWidth_Scale, 20, 20)];
    [LEDlightBtn setImage:[UIImage imageNamed:@"skin_1_scanQRcode_myhome_icon_flashbulb"] forState:UIControlStateNormal];
    [LEDlightBtn addTarget:self action:@selector(LEDSwitch) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:LEDlightBtn];
    //图库按钮
    UIButton *pictureBtn = [[UIButton alloc] initWithFrame:CGRectMake(293 * KWidth_Scale, 34 * KWidth_Scale, 20, 20)];
    [pictureBtn setImage:[UIImage imageNamed:@"skin_1_scanQRcode_myhome_icon_imge"] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:pictureBtn];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 478 * KWidth_Scale, SCREEN_WIDTH, 44 * KWidth_Scale)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"扫描二维码，即可查看产品详情";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self.backImageView addSubview:label];

    //返回按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 * KWidth_Scale, 34 * KWidth_Scale, 30, 20)];
    [backBtn setImage:[UIImage imageNamed:@"skin_1_search_home_icon_goback"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:backBtn];
}


- (void)LEDSwitch
{
    if (!self.cameraAuthorized) {
        self.firstAlert = NO;
        [self showCameraAlert];
        return;
    }
    if (self.lightOn) {
        [self turnOffLed];
    }
    else {
        [self turnOnLed];
    }
    self.lightOn = !self.lightOn;
}

- (void)choosePicture:(UIButton *)sender
{
    NSLog(@"选择图片!!!!");
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];

    [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

    ipc.delegate = self;

    ipc.allowsEditing = YES;

    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)configCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:mediaType
                                 completionHandler:^(BOOL granted) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                     if (granted) {
                                         //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                                         NSLog(@"Granted access to %@", mediaType);
                                         [self setupCamera];
                                     }
                                     else {
                                         //用户拒绝
                                         NSLog(@"Not granted access to %@", mediaType);
                                         [self showCameraAlert];
                                     }
                                   });
                                 }];
    }
    else if (authStatus == AVAuthorizationStatusAuthorized) {
        [self setupCamera];
    }
    else {
        [self showCameraAlert];
        NSLog(@"相机权限受阻");
    }
}

- (void)setupTime
{
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer invalidate];
    self.timer = nil;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 / 60.0 target:self selector:@selector(changeLineFrame) userInfo:nil repeats:YES];
    }
}

- (void)setupCamera
{
    if (![AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo]) {
        [self showCameraAlert];
        return;
    }


    self.cameraAuthorized = YES;
    self.backView.backgroundColor = [UIColor clearColor];

    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    //    _output = [[AVCaptureStillImageOutput alloc] init];

    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];


    //38
    //158
    //300
    //设置扫描区域大小
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    //    [_output setRectOfInterest:CGRectMake((38*KWidth_Scale)/width,(158*KWidth_Scale)/height,300.f*KWidth_Scale/width, 300.f*KWidth_Scale/height)];
    [_output setRectOfInterest:CGRectMake((158 * KWidth_Scale) / height, (38 * KWidth_Scale) / width, 300.f * KWidth_Scale / height, 300.f * KWidth_Scale / width)];

    // Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }

    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }

    _output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode ];


    [self.preview removeFromSuperlayer];
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //_preview.frame =CGRectMake(20,110,280,280);
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    _preview.frame = rect;
    [self.view.layer insertSublayer:self.preview atIndex:0];

    // Start
    [_session startRunning];
}

- (void)showCameraAlert
{
    //    self.backView.backgroundColor = [UIColor blackColor];
    self.cameraAuthorized = NO;
    if (!self.firstAlert) {
        [LGAlertViewExtension showAlertTitle:@"未获得授权使用摄像头"
                                 cancelTitle:@"取消"
                               cancelHandler:nil
                            destructiveTitle:@"设置"
                          destructiveHandler:^{
                            //进入设置
                            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                [[UIApplication sharedApplication] openURL:url];
                            }
                          }];
    }
}

- (void)turnOffLed
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

- (void)turnOnLed
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}
- (void)changeLineFrame
{
    _line.frame = CGRectMake(_line.frame.origin.x, _line.frame.origin.y + 2, _line.frame.size.width, _line.frame.size.height);
    if (_line.frame.origin.y >= 225 * KWidth_Scale) {
        _line.frame = CGRectMake(_line.frame.origin.x, -74, _line.frame.size.width, _line.frame.size.height);
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        NSString *type = metadataObj.type;
        if ([type isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSLog(@"22---%@", metadataObj.type);
            if (!self.loadingLabel) {
                self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
                self.loadingLabel.center = CGPointMake(self.baseLineView.frame.size.width / 2.0, self.baseLineView.frame.size.height / 2.0);
                [self.baseLineView insertSubview:self.loadingLabel aboveSubview:self.line];
                self.loadingLabel.backgroundColor = [UIColor blackColor];
                self.loadingLabel.layer.cornerRadius = 8;
                self.loadingLabel.clipsToBounds = YES;
                self.loadingLabel.text = @"正在识别二维码";
                self.loadingLabel.font = [UIFont systemFontOfSize:16];
                self.loadingLabel.textColor = [UIColor whiteColor];
                self.loadingLabel.textAlignment = NSTextAlignmentCenter;
            }

            result = metadataObj.stringValue;
            [self stopReading];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [self.loadingLabel removeFromSuperview];
              self.loadingLabel = nil;
              [self.baseLineView removeFromSuperview];
              self.baseLineView = nil;

              if (result)
                  [self handlingByScanResult:result];
              NSLog(@"result - %@", result);
            });
        }
        else {
            NSLog(@"不是二维码");

            [LGAlertViewExtension showAlertTitle:@"不是二维码，扫描失败" cancelTitle:nil cancelHandler:nil destructiveTitle:@"确定" destructiveHandler:nil];
        }
    }
}

- (void)stopReading
{
    // 停止会话
    [_session stopRunning];
    _session = nil;
}

//扫描完以后需要的逻辑
- (void)handlingByScanResult:(NSString *)result
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未找到产品，请重新扫描二维码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *_Nonnull action) {
                                                       [self configCamera];
                                                       self.baseLineView.backgroundColor = [UIColor clearColor];
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 选择相片的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagePicked = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self systemRecognizeQRcode:imagePicked];
    [picker dismissViewControllerAnimated:YES
                               completion:^(){
                               }];
}

- (void)systemRecognizeQRcode:(UIImage *)image
{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    for (int index = 0; index < features.count; index++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *result = feature.messageString;
        if (result) {
            NSLog(@"---,result--%@", result);
            [self handlingByScanResult:result];
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
