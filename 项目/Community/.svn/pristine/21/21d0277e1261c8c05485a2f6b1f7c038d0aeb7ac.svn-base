//
//  HWSearchBarView.m
//  SearchLocation
//
//  Created by caijingpeng.haowu on 14-6-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWSearchBarView.h"
#import "HWAreaClass.h"
#define CANCEL_BUTTON_WIDTH     40
#define SEARCH_BAR_HEIGHT       50
#define ANIMATE_RATE            0.3f
#define INSET_WIDTH             15

@implementation HWSearchBarView
@synthesize frameMaxHeight, delegate, _searchTF,cityOrCommunityFlag;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SEARCH_BAR_HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
//        self.backgroundColor = [UIColor redColor];
        
        _textBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SEARCH_BAR_HEIGHT)];
        _textBackgroundImageView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        [self addSubview:_textBackgroundImageView];
        
        _searchBackView = [[UIView alloc] initWithFrame:CGRectMake(INSET_WIDTH, 8.0f, frame.size.width - 2 * INSET_WIDTH, _textBackgroundImageView.frame.size.height - 2 * 8.0f)];
        _searchBackView.layer.cornerRadius = 4.0f;
        _searchBackView.layer.borderWidth = 0.5f;
        _searchBackView.layer.borderColor = THEME_COLOR_LINE.CGColor;
        _searchBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_searchBackView];
        
        UIImageView *glassImgV = [[UIImageView alloc] initWithFrame:CGRectMake(5, (_searchBackView.frame.size.height - 13) / 2.0f, 13, 13)];
        glassImgV.image = [UIImage imageNamed:@"glass"];
        glassImgV.backgroundColor = [UIColor clearColor];
        [_searchBackView addSubview:glassImgV];
        
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(glassImgV.frame) + 5, 0, _searchBackView.frame.size.width - 10 - glassImgV.frame.size.width, _searchBackView.frame.size.height)];
        _searchTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        _searchTF.backgroundColor = [UIColor whiteColor];
        _searchTF.delegate = self;
        _searchTF.font = [UIFont fontWithName:FONTNAME size:13.0f];
        _searchTF.borderStyle = UITextBorderStyleNone;
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.placeholder = @"搜索";
        [_searchBackView addSubview:_searchTF];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        [_cancelButton setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
        _cancelButton.frame = CGRectMake(CGRectGetMaxX(_searchBackView.frame) + 15, (SEARCH_BAR_HEIGHT - 30) / 2.0f, CANCEL_BUTTON_WIDTH, 30);
        [_cancelButton addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:line];
        
        _searchResultTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _searchResultTV.dataSource = self;
        _searchResultTV.delegate = self;
        _searchResultTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _searchResultTV.hidden = YES;
        _searchResultTV.backgroundColor = UIColorFromRGB(0xeeeeee);
        _searchResultTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_searchResultTV];
        
        _dataSource = [NSMutableArray array];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doCancel:)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)textValueChange:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendTextChange) object:nil];
    [self performSelector:@selector(sendTextChange) withObject:nil afterDelay:0.5f];
}

- (void)sendTextChange
{
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textChange:)])
    {
        [delegate searchBar:self textChange:_searchTF.text];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
}

- (BOOL)isFirstResponder
{
    return [_searchTF isFirstResponder];
}

- (void)setSearchResultData:(NSArray *)dataSource
{
    [_dataSource removeAllObjects];
    if (cityOrCommunityFlag == YES) {
        if ([dataSource count]>0) {
            _dataSource = [NSMutableArray arrayWithArray:dataSource];
            
        }else{
            HWAreaClass *noResult = [[HWAreaClass alloc]init];
            //noResult.villageNameStr = @"无结果";
            _dataSource = [NSMutableArray arrayWithObjects:noResult, nil];
        }

    }
    else
    {
        if ([dataSource count]>0) {
            _dataSource = [NSMutableArray arrayWithArray:dataSource];
            
        }else{
            HWCityClass *noResult = [[HWCityClass alloc]init];
            //noResult.cityName = @"无结果";
            _dataSource = [NSMutableArray arrayWithObjects:noResult, nil];
        }

    }
    [self showSearchResultTableView];
}

- (void)showSearchResultTableView
{
    _searchResultTV.hidden = NO;
    _searchResultTV.frame = CGRectMake(0, CGRectGetMaxY(_textBackgroundImageView.frame) , self.frame.size.width, frameMaxHeight - _textBackgroundImageView.frame.size.height);
    [_searchResultTV reloadData];
}

- (void)hideSearchResultTableView
{
    _searchResultTV.hidden = YES;
    _searchResultTV.frame = CGRectZero;
}

//- (void)searchResignFirstResponder
//{
//    [_searchTF resignFirstResponder];
//    [UIView animateWithDuration:ANIMATE_RATE animations:^{
//        _searchBackView.frame = CGRectMake(_searchBackView.frame.origin.x,
//                                           _searchBackView.frame.origin.y,
//                                           self.frame.size.width - 2 * INSET_WIDTH,
//                                           _searchBackView.frame.size.height);
//        _searchTF.frame = CGRectMake(_searchTF.frame.origin.x,
//                                     _searchTF.frame.origin.y,
//                                     _searchBackView.frame.size.width - 10 - 13,
//                                     _searchTF.frame.size.height);
//        _cancelButton.frame = CGRectMake(CGRectGetMaxX(_searchBackView.frame) + 15,
//                                         (SEARCH_BAR_HEIGHT - 30) / 2.0f,
//                                         CANCEL_BUTTON_WIDTH,
//                                         30);
//        self.backgroundColor = [UIColor clearColor];
//        
//        [self hideSearchResultTableView];
//        
//    }completion:^(BOOL finished) {
//        self.frame = CGRectMake(self.frame.origin.x,
//                                self.frame.origin.y,
//                                self.frame.size.width,
//                                SEARCH_BAR_HEIGHT);
//    }];
//}
//- (void)searchBecameFirstResponder
//{
//    self.frame = CGRectMake(self.frame.origin.x,
//                            self.frame.origin.y,
//                            self.frame.size.width,
//                            [UIScreen mainScreen].bounds.size.height);
//    
//    [UIView animateWithDuration:ANIMATE_RATE animations:^{
//    _searchBackView.frame = CGRectMake(_searchBackView.frame.origin.x,
//                                           _searchBackView.frame.origin.y,
//                                           self.frame.size.width - 2 * INSET_WIDTH - CANCEL_BUTTON_WIDTH,
//                                           _searchBackView.frame.size.height);
//        _searchTF.frame = CGRectMake(_searchTF.frame.origin.x,
//                                     _searchTF.frame.origin.y,
//                                     _searchBackView.frame.size.width - 10 - 13,
//                                     _searchTF.frame.size.height);
//        _cancelButton.frame = CGRectMake(CGRectGetMaxX(_searchBackView.frame) + 3,
//                                         (SEARCH_BAR_HEIGHT - 30) / 2.0f,
//                                         CANCEL_BUTTON_WIDTH,
//                                         30);
//        
//        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
//    }];
//}

- (void)doCancel:(id)sender
{
    _searchTF.text = @"";
    
    [self searchResignFirstResponder];
}

- (void)selected:(NSString *)selectStr
{
    _searchTF.text = selectStr;
    [self searchResignFirstResponder];
}

- (void)setSearchBarPlaceholder:(NSString *)placeholder
{
    _searchTF.placeholder = placeholder;
}

#pragma mark --------------- UITableViewDelegate DataSource -----------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%d",indexPath.section];
    HWSearchBarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HWSearchBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
     if (cityOrCommunityFlag == YES) {
         HWAreaClass *areaInfo = [_dataSource objectAtIndex:indexPath.row];
         cell.labelCell.text = areaInfo.villageNameStr;
     }
    else
    {
        HWCityClass *cityInfo = [_dataSource objectAtIndex:indexPath.row];
        cell.labelCell.text = cityInfo.cityName;
    }
   
    
    
//    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strResult;
    NSString *strAddressId;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (cityOrCommunityFlag == YES) {
        HWAreaClass *areaInfo = [_dataSource objectAtIndex:indexPath.row];
        strResult = areaInfo.villageNameStr;
        strAddressId = areaInfo.villageIdStr;

    }
    else
    {
        HWCityClass *areaInfo = [_dataSource objectAtIndex:indexPath.row];
        strResult = areaInfo.cityName;
        strAddressId = areaInfo.cityId;
    }
    if ([strResult isEqualToString:@"无结果"])
    {
        return;//无结果不能点击
    }
    if (cityOrCommunityFlag == YES) {
        if (delegate && [delegate respondsToSelector:@selector(searchBar:didSelectSearchResult:villageId: flag:)])
        {
            [delegate searchBar:self didSelectSearchResult:strResult villageId:strAddressId  flag:NO];
        }

    }
    else
    {
        if (delegate && [delegate respondsToSelector:@selector(searchBar:didSelectSearchResult:villageId: flag:)])
        {
            [delegate searchBar:self didSelectSearchResult:strResult villageId:strAddressId flag:NO];
        }
    }
    self._searchTF.text = strResult;
    [self resignFirstResponder];
    [self searchResignFirstResponder];
}


#pragma mark --------------- UITextFieldDelegate ---------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendTextChange) object:nil];
    [self performSelector:@selector(sendTextChange) withObject:nil afterDelay:0.5f];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (delegate && [delegate respondsToSelector:@selector(searchViewHide)])
    {
        [delegate searchViewHide];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (delegate && [delegate respondsToSelector:@selector(searchBarEnd)])
    {
        [delegate searchBarEnd];
    }
    [_searchTF resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:didSelectSearchResult:villageId: flag:)])
    {
        [delegate searchBar:self didSelectSearchResult:textField.text villageId:nil flag:YES];
    }
    [_searchTF resignFirstResponder];
    //[self searchResignFirstResponder];
    
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}




@end
