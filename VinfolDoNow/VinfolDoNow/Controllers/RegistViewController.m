//
//  RegistViewController.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import "GestureManager.h"
#import "AppDelegate.h"
#import "DBBusinessManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RegistViewController ()<RegistViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) RegistView *registView;
@property (nonatomic, strong) UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
@property (nonatomic, strong) UILabel *alertLabel;//密码不正确提示
@property (nonatomic, copy) NSString *headImageName;//头像名

@end

@implementation RegistViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.registView];
    [self.view addSubview:self.alertLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[GestureManager sharedGestureManager].tapGesture addTarget:self action:@selector(viewTapped:)];
     [self.registView addGestureRecognizer:[GestureManager sharedGestureManager].tapGesture];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

#pragma mark - RegistViewDelegate
- (void)presentPhotoView
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //设置来源了类型为图片库和相机
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取选择的图片类型为原图
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //修改全局图片
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    del.headImage = image;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    [self.registView.headImageBtn setBackgroundImage:image forState:UIControlStateNormal];
//    //把图片转为data
//    NSData *data = UIImagePNGRepresentation(image);
//    //图片保存的路径
//    //这里将图片放在沙盒的documents文件夹中
//    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    //文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
//    [fileManager createFileAtPath:[documentPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//    self.filePath = [[NSString alloc] initWithFormat:@"%@%@",documentPath,@"/image.png"];
    //获取点选图片时，获取图片名称
    NSURL *imageURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        self.headImageName = [representation filename];
        NSLog(@"fileName : %@",self.headImageName);
        //将图片的后缀名切除
        NSArray *arr = [self.headImageName componentsSeparatedByString:@"."];
        self.headImageName = arr[0];
        //将选择的图片放到沙盒中
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [path objectAtIndex:0];
        NSString *HeadPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",self.headImageName]];
        //将图片输出为png,并写入沙盒指定路径
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:HeadPath atomically:YES];
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - override methods

- (NSString *)getNavigationTitle
{
    return @"注册用户";
}

- (UIBarButtonItem *)getLeftBarButtonItem
{
    return self.leftBarButton;
}

- (UIBarButtonItem *)getRightBarButtonItem
{
    return self.rightBarButton;
}

#pragma mark - private methods


#pragma mark - event respond
- (void)leftBarButtonOnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)rightBarButtonOnClicked:(id)sender
{
    NSString *str1 = self.registView.firstPassTextField.text;
    NSString *str2 = self.registView.secondPassTextField.text;
    NSString *phone = self.registView.phoneTextField.text;
    NSString *name = self.registView.nameTextField.text;
    NSString *email = self.registView.emailTextField.text;
    NSString *birth = self.registView.birthTextField.text;
    
    if ([phone isEqualToString:@""] || [str1 isEqualToString:@""] || [str2 isEqualToString:@""]) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.alertLabel setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:4.0 animations:^{
                [self.alertLabel setAlpha:0];
            } completion:nil];
        }];
    }
    else {
        if ([str1 isEqualToString:str2]) {
            [self dismissViewControllerAnimated:YES completion:^{
                if ([self.delegate respondsToSelector:@selector(registerSuccess)]) {
                    [self.delegate registerSuccess];
                }
            }];
            [[DBBusinessManager sharedDBBusinessManager] userInfoInsertWithPhone:phone password:str1 login:@"NO" autoLogin:@"NO" rememberPass:@"NO"];
            [[DBBusinessManager sharedDBBusinessManager] basicInfoInsertWithPhone:phone name:name email:email birth:birth head:self.headImageName];
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                [self.alertLabel setAlpha:1.0f];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:4.0 animations:^{
                    [self.alertLabel setAlpha:0];
                } completion:nil];
            }];
        }
    }
}

- (void)viewTapped:(id)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        self.registView.frame = CGRectMake(0, 64*kAdaptPixel, kScreen_Width, kScreen_Height);
    } completion:^(BOOL finished) {}];
}

#pragma mark - setter and getter
- (RegistView *)registView
{
    if (!_registView) {
        _registView = [[RegistView alloc] init];
        _registView.delegate = self;
    }
    return _registView;
}

- (UIBarButtonItem *)leftBarButton
{
    if (!_leftBarButton) {
        _leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back@2x.png"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(leftBarButtonOnClicked:)];
        _leftBarButton.tintColor = [UIColor whiteColor];
    }
    return _leftBarButton;
}

- (UIBarButtonItem *)rightBarButton
{
    if (!_rightBarButton) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonOnClicked:)];
        [_rightBarButton setTintColor:[UIColor cyanColor]];
    }
    return _rightBarButton;
}

- (UILabel *)alertLabel
{
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreen_Height - 100*kAdaptPixel, 300*kAdaptPixel, 50*kAdaptPixel)];
        _alertLabel.centerX = kScreen_Width/2;
        _alertLabel.text = @"请输入正确信息或密码！";
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.textColor = [UIColor redColor];
        _alertLabel.font = [UIFont systemFontOfSize:20*kAdaptPixel];
        _alertLabel.alpha = 0;
    }
    return _alertLabel;
}

@end
