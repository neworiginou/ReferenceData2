//
//  UserInformationVC.m
//  PUClient
//
//  Created by RRLhy on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "UserInformationVC.h"
#import "CityVC.h"
#import "RRMJTool.h"
#import "UploadIconApi.h"
@interface UserInformationVC ()<UITextViewDelegate,CityDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIDatePicker * _dateView;
    
    NSString * _nick;
    NSString * _birthday;
    NSString * _sex;
    NSString * _sign;
    NSString * _city;
    BOOL _changeImg;
}
@property (weak, nonatomic) IBOutlet UITextView *signTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickLabel;

@end

@implementation UserInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"个人资料";
    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    _nickLabel.delegate = self;
    
    RrmjUser * me = [UserInfoConfig sharedUserInfoConfig].userInfo;
    NSString * city = [RRMJTool getKeyWith:me.city];
    [_userImage sd_setImageWithURL:URL(me.headImgUrl) placeholderImage:IMAGENAME(@"login_me_user-no")];
    [_nickLabel setText:me.nickName];
    [_birthdayLabel setText:me.birthday];
    [_cityLabel setText:city];

    if (me.sign.length) {
        [_signTextView setText:me.sign];
        [_placeHolderLabel setText:nil];
    }

    if ([me.sex isEqualToString:@"0"]) {
        [_sexLabel setText:@"女"];
    }else if ([me.sex isEqualToString:@"1"]){
        [_sexLabel setText:@"男"];
    }else{
        [_sexLabel setText:@"保密"];
    }
    
    _nick = me.nickName;
    _city = me.city;
    _sex = me.sex;
    _birthday = me.birthday;
    _sign = me.sign;
    
    [self addDateView];
}

#pragma mark 添加选择日期
- (void)addDateView
{
    // 这里是添加辅助视图的做法
    // 1.创建时间选择器
    _dateView = [[UIDatePicker alloc] init];
    _dateView.backgroundColor = [UIColor whiteColor];
    // 设置只显示日期
    _dateView.datePickerMode = UIDatePickerModeDate;
    // 设置日期为中文
    _dateView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _dateView.frame = CGRectMake(0, self.view.frame.size.height, Main_Screen_Width, 162);
    _dateView.maximumDate = [NSDate date];
    [_dateView addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
    //获取控件的子视图
    UIView *pickerView = [[_dateView subviews] objectAtIndex:0];
    pickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dateView];
}

- (void)selectDate:(UIDatePicker*)datePicker
{
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * birthday = [formatter stringFromDate:selectedDate];
    
    //判断生日是否改变
    if ([self.birthdayLabel.text isEqualToString:birthday]) {
        return;
    }
    self.birthdayLabel.text = [formatter stringFromDate:selectedDate];
    _birthday = birthday;
    [self compareValueIsChange];
}

#pragma mark datePicker 动画
- (void)dateViewAnimation
{
    [UIView animateWithDuration:0.25 animations:^{
        _dateView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - 162, Main_Screen_Width, 162);
    }];
}

- (void)dateViewDismissAnimation
{
    [UIView animateWithDuration:0.25 animations:^{
        _dateView.frame = CGRectMake(0,CGRectGetHeight(self.view.frame), Main_Screen_Width, 162);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    //修改图像
                {
                    [self resignTextField];
                    UIActionSheet * myActionSheet = [[UIActionSheet alloc]
                                                     initWithTitle:@"请选择照片来源"
                                                     delegate:self
                                                     cancelButtonTitle:@"取消"
                                                     destructiveButtonTitle:nil
                                                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
                    myActionSheet.tag = 10;
                    [myActionSheet showInView:self.view];
                }
                    
                    break;
                case 2:
                    //修改性别
                {
                    [self resignTextField];
                    UIActionSheet * sexActionSheet = [[UIActionSheet alloc]
                                                     initWithTitle:nil
                                                     delegate:self
                                                     cancelButtonTitle:@"取消"
                                                     destructiveButtonTitle:@"保密"
                                                     otherButtonTitles: @"女", @"男",nil];
                    sexActionSheet.tag = 20;
                    [sexActionSheet showInView:self.view];
                }
                    break;
                case 3:
                    //修改生日
                    [self resignTextField];
                    [self dateViewAnimation];
                    break;
                case 4:
                    //选择城市
                    [self resignTextField];
                    [self performSegueWithIdentifier:@"city" sender:self];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            NSArray * array = @[@"changePsd",@"myBound"];
            [self performSegueWithIdentifier:array[indexPath.row] sender:self];
        
        }
            break;
        default:
            break;
    }
}

#pragma mark 图像模块
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10) {
        //呼出的菜单按钮点击后的响应
        switch (buttonIndex){
                
            case 0:  //打开照相机拍照
                
                [self takePhoto];
                
                break;
                
            case 1:  //打开本地相册
                
                [self LocalPhoto];
                
                break;
        }
    }else{
        
        if (buttonIndex<3) {
            NSArray * keyArray = @[@"保密",@"女",@"男"];
            NSArray * valueArray = @[@"",@"0",@"1"];
            _sexLabel.text = keyArray[buttonIndex];
            _sex = valueArray[buttonIndex];
            [self compareValueIsChange];
        }
    }
}
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }else{
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}
- (void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        
        //先把图片转成NSData
        UIImage * imageData = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //对图片大小进行压缩--
        //imageData = [LGTools fixOrientation:imageData];
         NSData * data = UIImageJPEGRepresentation(imageData, 0.4f);
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
            _userImage.image = [UIImage imageWithData:data];
        }];
        
        _changeImg = YES;
        [self compareValueIsChange];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark tableview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.1;
    }
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (Y(_dateView)<App_Frame_Height) {
        [self dateViewDismissAnimation];
    }
    self.navImage.frame = CGRectMake(self.navImage.frame.origin.x, 0 + self.tableView.contentOffset.y , self.navImage.frame.size.width,self.navImage.frame.size.height);
}

#pragma mark 完成编辑
- (void)rightBtnClick {
    
    NSString * nick = _nickLabel.text;
    if (![nick replaceString].length) {
        nick = @"";
    }
    NSString * sex = _sexLabel.text;
    if ([sex isEqual:@"女"]) {
        sex = @"0";
    }else if ([sex isEqualToString:@"男"]){
        sex = @"1";
    }else{
        sex = @"";
    }
    NSString * birthday = _birthdayLabel.text;
    if (!birthday.length) {
        birthday = @"";
    }
    
    NSString * city = _cityLabel.text;
    if (city.length) {
        city = [RRMJTool getValueWithCity:city];
    }else{
        city = @"";
    }
    
    NSString * sign = _signTextView.text;
    if (!sign.length) {
        sign = @"";
    }
    
    [IanAlert showloadingAllowUserInteraction:NO];
    UIImage * image;
    if (_changeImg) {
        image = _userImage.image;
    }
    UploadIconApi * api = [[UploadIconApi alloc]initWith:image nickName:nick sex:sex birthDay:birthday city:city sign:sign token:[UserInfoConfig sharedUserInfoConfig].userInfo.token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            NSLog(@"%@",dic);
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            if (json.code == SUCCESSCODE) {
                [IanAlert alertSuccess:@"修改成功" length:1];
                NSDictionary * userView = json.data[@"sessionUserView"];
                RrmjUser * user = [RrmjUser objectWithKeyValues:userView];
                RrmjUser * me = [UserInfoConfig sharedUserInfoConfig].userInfo;
                me.nickName = user.nickName;
                me.headImgUrl = user.headImgUrl;
                me.sex = user.sex;
                me.birthday = user.birthday;
                me.sign = user.sign;
                me.city = user.city;
                [[UserInfoConfig sharedUserInfoConfig] saveRRMJUser:me];
                self.rightBtn.hidden = YES;
                [self performSelector:@selector(popRootTableViewController) withObject:nil afterDelay:1];
                
            }else{
                
                [IanAlert alertError:json.msg length:1];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:1];
        }
        
    } failure:^(YTKBaseRequest *request) {
        
        [IanAlert alertError:ERRORMSG2 length:1];
    }];
}

#pragma mark 返回
- (void)popViewController
{
    if (!self.rightBtn.hidden) {
        UIAlertView * view = [[UIAlertView alloc]initWithTitle:nil message:@"是否放弃修改资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"是",@"否", nil];
        [view show];
        
    }else{
        
         [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark textView 代理
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        
        _placeHolderLabel.text = @"暂无个性签名";
        
    }else{
        
        _placeHolderLabel.text = nil;
        NSInteger  num = 140 - textView.text.length + 1;
        _numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _sign = textView.text;
    [self compareValueIsChange];
}

#pragma textField 代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _nick = textField.text;
    [self compareValueIsChange];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"city"]) {
        CityVC * theSegu = segue.destinationViewController;
        theSegu.delegate = self;
    }
}

#pragma mark 选择城市
- (void)selectedCity:(NSString *)selectName
{
    _cityLabel.text = selectName;
    _city = [RRMJTool getValueWithCity:selectName];
    [self compareValueIsChange];
}

#pragma mark 判断资料是否改动
- (void)compareValueIsChange
{
    RrmjUser * user = [UserInfoConfig sharedUserInfoConfig].userInfo;
    
    if (![_nick isEqualToString:user.nickName]||
        ![_birthday isEqualToString:user.birthday]||
        ![_sex isEqualToString:user.sex]||
        ![_city isEqualToString:user.city]||
        ![_sign isEqualToString:user.sign]||_changeImg) {
        self.rightBtn.hidden = NO;
        
    }else{
        
        self.rightBtn.hidden = YES;
    }
}

- (void)resignTextField
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
