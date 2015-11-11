//
//  RegistView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "RegistView.h"

#define ArrNum 20  //防止留白

@interface RegistView ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *birthPickerView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) NSMutableArray *yearArr;
@property (nonatomic, strong) NSMutableArray *monthArr;
@property (nonatomic, strong) NSMutableArray *dayArr;
@property (nonatomic, strong) NSString *yearStr;
@property (nonatomic, strong) NSString *monthStr;
@property (nonatomic, strong) NSString *dayStr;
@property (nonatomic, strong) NSString *birthStr;

@end

@implementation RegistView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 64*kAdaptPixel, kScreen_Width, kScreen_Height)];
    if (self) {
        [self addSubview:self.headImageBtn];
        [self addLabel];
        [self addTextField];
        [self addSubview:self.selectedBtn];
        [self addSubview:self.birthPickerView];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //按return自动跳到下一行
    if (textField == self.phoneTextField) {
        [self.emailTextField becomeFirstResponder];
    }
    else if (textField == self.emailTextField) {
        [self.birthTextField becomeFirstResponder];
        [self.birthPickerView setAlpha:1.0f];
        [self.selectedBtn setAlpha:1.0f];
    }
    else if (textField == self.birthTextField) {
        [self.nameTextField becomeFirstResponder];
    }
    else if (textField == self.nameTextField) {
        [self.firstPassTextField becomeFirstResponder];
    }
    else if (textField == self.firstPassTextField) {
        [self.secondPassTextField becomeFirstResponder];
    }
    else {
        [self.secondPassTextField resignFirstResponder];
        [UIView animateWithDuration:0.1 animations:^{
            self.frame = CGRectMake(0, 64*kAdaptPixel, kScreen_Width, kScreen_Height);
        } completion:^(BOOL finished) {}];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(0, -50*kAdaptPixel, kScreen_Width, kScreen_Height);
    } completion:^(BOOL finished) {}];
    if (textField == self.birthTextField) {
        [self.birthPickerView setAlpha:1.0f];
        [self.selectedBtn setAlpha:1.0f];
    }
}

#pragma mark - UIPickerViewDelegate&UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.yearArr count]*ArrNum;
    }
    else if (component == 1) {
        return [self.monthArr count]*ArrNum;
    }
    else {
        return [self.dayArr count]*ArrNum;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40*kAdaptPixel;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.width/3, 40*kAdaptPixel)];
    if (component == 0) {
        label.text = [NSString stringWithFormat:@"%@",[self.yearArr objectAtIndex:row%[self.yearArr count]]];
    }
    else if (component == 1) {
        label.text = [NSString stringWithFormat:@"%@",[self.monthArr objectAtIndex:row%[self.monthArr count]]];
    }
    else {
        label.text = [NSString stringWithFormat:@"%@",[self.dayArr objectAtIndex:row%[self.dayArr count]]];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25.0*kAdaptPixel];
    label.textColor = [UIColor whiteColor];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.yearStr = self.yearArr[row%[self.yearArr count]];
    }else if (component == 1) {
        self.monthStr = self.monthArr[row%[self.monthArr count]];
    }else {
        self.dayStr = self.dayArr[row%[self.dayArr count]];
    }
}

#pragma mark - event respond

- (void)headBtnOnClicked:(id)sender
{
    //打开图库
    if ([self.delegate respondsToSelector:@selector(presentPhotoView)]) {
        [self.delegate presentPhotoView];
    }
}

- (void)registerBtnOnClicked:(id)sender
{
    [self.secondPassTextField resignFirstResponder];
}

- (void)selectedBtnOnClicked:(id)sender
{
    [self.birthTextField setText:@""];
    self.birthStr = [NSString stringWithFormat:@"%@%@%@",self.yearStr,self.monthStr,self.dayStr];
    [self.birthTextField setText:self.birthStr];
    [self.nameTextField becomeFirstResponder];
    [self.birthPickerView setAlpha:0];
    [self.selectedBtn setAlpha:0];
}

#pragma mark - private methods
//创建textField
- (void)addTextField
{
    for (NSInteger i = 0; i < 6; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90*kAdaptPixel, 120*kAdaptPixel+(i*50*kAdaptPixel), kScreen_Width - 120*kAdaptPixel, 40*kAdaptPixel)];
        textField.alpha = 0.4f;
        textField.delegate = self;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        switch (i) {
            case 0:
                self.phoneTextField = textField;
                break;
            case 1:
                self.emailTextField = textField;
                break;
            case 2:
                self.birthTextField = textField;
                self.birthTextField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
                break;
            case 3:
                self.nameTextField = textField;
                break;
            case 4:
                self.firstPassTextField = textField;
                textField.secureTextEntry = YES;
                break;
            case 5:
                self.secondPassTextField = textField;
                textField.secureTextEntry = YES;
                break;
            default:
                break;
        }
        [self addSubview:textField];
    }
}

//创建label
- (void)addLabel
{
    for (NSInteger i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*kAdaptPixel, 120*kAdaptPixel+(i*50*kAdaptPixel), 70*kAdaptPixel, 40*kAdaptPixel)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:16.0*kAdaptPixel];
        label.tag = i + 1000;
        label.textColor = [UIColor whiteColor];
        switch (i) {
            case 0:
                label.text = @"手机:";
                break;
            case 1:
                label.text = @"邮箱:";
                break;
            case 2:
                label.text = @"出生日期:";
                break;
            case 3:
                label.text = @"姓名:";
                break;
            case 4:
                label.text = @"密码:";
                break;
            case 5:
                label.text = @"确认密码:";
                break;
            default:
                break;
        }
        [self addSubview:label];
    }
}

#pragma mark - getter and setter
- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        _headImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20*kAdaptPixel, 80*kAdaptPixel, 80*kAdaptPixel)];
        _headImageBtn.centerX = kScreen_Width/2;
        _headImageBtn.layer.cornerRadius = _headImageBtn.width/2.0;
        _headImageBtn.clipsToBounds = YES;
        _headImageBtn.alpha = 0.8f;
        [_headImageBtn setBackgroundImage:[UIImage imageNamed:@"add photo.png"] forState:UIControlStateNormal];
        [_headImageBtn addTarget:self action:@selector(headBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headImageBtn;
}

- (UIPickerView *)birthPickerView
{
    if (!_birthPickerView) {
        _birthPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 216*kAdaptPixel)];
        _birthPickerView.centerX = kScreen_Width/2;
        _birthPickerView.centerY = kScreen_Height - 100;
        _birthPickerView.showsSelectionIndicator = NO;
        _birthPickerView.delegate = self;
        _birthPickerView.dataSource = self;
        [_birthPickerView selectRow:[self.yearArr count]*ArrNum/2 inComponent:0 animated:NO];
        [_birthPickerView selectRow:[self.monthArr count]*ArrNum/2 inComponent:1 animated:NO];
        [_birthPickerView selectRow:[self.dayArr count]*ArrNum/2 inComponent:2 animated:NO];
        _birthPickerView.alpha = 0;
    }
    return _birthPickerView;
}

- (UIButton *)selectedBtn
{
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 60*kAdaptPixel, self.birthPickerView.y - 30*kAdaptPixel, 50*kAdaptPixel, 30*kAdaptPixel)];
        [_selectedBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectedBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kAdaptPixel];
        [_selectedBtn addTarget:self action:@selector(selectedBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn.alpha = 0;
    }
    return _selectedBtn;
}

- (NSMutableArray *)yearArr
{
    if (!_yearArr) {
        _yearArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 1910; i < 2030; i++) {
            NSString *str = [NSString stringWithFormat:@"%ld年",(long)i];
            [_yearArr addObject:str];
        }
    }
    return _yearArr;
}

- (NSMutableArray *)monthArr
{
    if (!_monthArr) {
        _monthArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 12; i++) {
            NSString *str = [NSString stringWithFormat:@"%ld月",(long)i];
            [_monthArr addObject:str];
        }
    }
    return _monthArr;
}

- (NSMutableArray *)dayArr
{
    if (!_dayArr) {
        _dayArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 31; i++) {
            NSString *str = [NSString stringWithFormat:@"%ld日",(long)i];
            [_dayArr addObject:str];
        }
    }
    return _dayArr;
}

- (NSString *)yearStr
{
    if (!_yearStr) {
        _yearStr = [[NSString alloc] init];
        _yearStr = self.yearArr[([self.yearArr count]*ArrNum/2)%[self.yearArr count]];
    }
    return _yearStr;
}

- (NSString *)monthStr
{
    if (!_monthStr) {
        _monthStr = [[NSString alloc] init];
        _monthStr = self.monthArr[([self.monthArr count]*ArrNum/2)%[self.monthArr count]];
    }
    return _monthStr;
}

- (NSString *)dayStr
{
    if (!_dayStr) {
        _dayStr = [[NSString alloc] init];
        _dayStr = self.dayArr[([self.dayArr count]*ArrNum/2)%[self.dayArr count]];
    }
    return _dayStr;
}

- (NSString *)birthStr
{
    if (!_birthStr) {
        _birthStr = [[NSString alloc] init];
    }
    return _birthStr;
}

@end
