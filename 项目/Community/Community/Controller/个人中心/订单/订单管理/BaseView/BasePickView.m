//
//  BasePickView.m
//  Community
//
//  Created by hw500028 on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "BasePickView.h"
@implementation BasePickView



- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _allProvinces = [[NSMutableArray alloc]init];
        _allCities = [[NSMutableArray alloc]init];
        _allAreas = [[NSMutableArray alloc]init];
        [self setProvinceData];
    }
    return self;
}

- (void)setProvinceData{
    // 加载省份数据
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    for (NSDictionary *dic in array) {
        
        NSString *provinceName = dic[@"state"];
        [_allProvinces addObject:provinceName];
        NSArray *arr = dic[@"cities"];
        [_allCities addObject:arr];
        
    }
    
    
}
#pragma mark - PickViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0)
    {
        return _allProvinces.count;
    }
    else if(component == 1)
    {
        NSUInteger pIndex = [pickerView selectedRowInComponent:0];
        NSArray *arr = _allCities[pIndex];
        return arr.count;
    }
    else{
        NSUInteger pIndex = [pickerView selectedRowInComponent:0];
        NSArray *arr = _allCities[pIndex];
        NSUInteger cIndex = [pickerView selectedRowInComponent:1];
        NSDictionary *dic = arr[cIndex];
        NSArray *area = dic[@"areas"];
        return area.count;
    
    }
    
}

#pragma mark 每列每行显示什么数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        return _allProvinces[row];
    }
    else if(component == 1)
    {
        // 获取省份的位置
        NSUInteger pIndex = [pickerView selectedRowInComponent:0];
        NSArray *cities;
        NSString *cityName;
        if([_allCities count]>pIndex)
        {
             cities =_allCities[pIndex];
        }
        if ([cities count]>row) {
              NSDictionary *city = cities[row];
              cityName = city[@"city"];
        }
        return cityName;
    }
    else
    {
    
        NSUInteger pIndex = [pickerView selectedRowInComponent:0];
        NSArray *arr;
        if ([_allCities count]>pIndex) {
            arr = _allCities[pIndex];
        }
        
        NSUInteger cIndex = [pickerView selectedRowInComponent:1];
        NSDictionary *dic;
        if ([arr count]>cIndex) {
             dic = arr[cIndex];
        }
        NSArray *area = dic[@"areas"];
        NSString *str = [[NSString alloc]init];
        if (area.count == 0) {
            str = nil;
        }
        else {
            if ([area count]>row) {
                str = area[row];
            }
    }
        return str;
    }
}

#pragma mark UIPickerView选中了某一行就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 刷新第1列的数据
    [pickerView reloadComponent:1];
    [pickerView reloadComponent:2];
    
    
    NSUInteger pIndex = [pickerView selectedRowInComponent:0];
    NSString *pName = _allProvinces[pIndex];
    NSArray *arr = _allCities[pIndex];
    NSUInteger cIndex = [pickerView selectedRowInComponent:1];
    NSDictionary *dic = arr[cIndex];
    NSString * cName = dic[@"city"];
    NSArray *area = dic[@"areas"];
    NSString *areaName = @"";
    if (area.count == 0) {
        areaName = @"";
    }
    else {
        NSUInteger pIndex = [pickerView selectedRowInComponent:2];
        areaName = area[pIndex];
    }
    self.address = [NSString stringWithFormat:@"%@  %@  %@",pName,cName,areaName];
    if ([self.addressdelegate respondsToSelector:@selector(sentAddress:)]) {
        [self.addressdelegate sentAddress:self.address];
    }

}



@end
