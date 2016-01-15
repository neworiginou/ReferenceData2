//
//  HWInviteCustomVC.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomVC.h"
#import "HWInviteCustomView.h"
#import "HWInviteCustomRecordVC.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface HWInviteCustomVC ()<HWInviteCustomViewDelegate, ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>
{
    HWInviteCustomView *_mainView;
}
@end

@implementation HWInviteCustomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"邀请访客"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"记录" action:@selector(visitRecordBtnClick)];
    
    _mainView = [[HWInviteCustomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) recordModel:self.recordModel];
    _mainView.delegate = self;
    _mainView.fatherVC = self;
    [self.view addSubview:_mainView];
    
}

- (void)visitRecordBtnClick
{
    if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
    {
        HWInviteCustomRecordVC *rVC = [[HWInviteCustomRecordVC alloc] init];
        [self pushViewController:rVC];
    }
}

- (void)visitPhoneBook
{
    ABPeoplePickerNavigationController *picker;
    if(!picker){
        picker = [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)pushViewController:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark --ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property == kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, property);
        CFIndex index = ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *firstName, *lastName, *fullName;
        firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if (!firstName) {
            firstName = @"";
        }
        firstName = [firstName stringByAppendingFormat:@" "];
        lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (!lastName) {
            lastName = @"";
        }
        fullName = [lastName stringByAppendingString:firstName];
        
        NSString *phone =  (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        [_mainView phoneBookSet:phone name:fullName];
        
//        NSMutableString * str  =(NSMutableString * )phone;
//        NSRange range = [str rangeOfString:@"-"];
//        
//        if ( range.length > 0 ) {
//            
//            [str deleteCharactersInRange:range];
//        }
        
        
//        _idtV.phoneNumberText.text = [[[phone stringByReplacingOccurrencesOfString:@"-" withString:@""]stringByReplacingOccurrencesOfString:@"+86" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property == kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, property);
        CFIndex index = ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *firstName, *lastName, *fullName;
        firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if (!firstName) {
            firstName = @"";
        }
        firstName = [firstName stringByAppendingFormat:@" "];
        lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (!lastName) {
            lastName = @"";
        }
        fullName = [lastName stringByAppendingString:firstName];
        
        NSString *phone =  (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        [_mainView phoneBookSet:phone name:fullName];
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    return NO;
}

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
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
