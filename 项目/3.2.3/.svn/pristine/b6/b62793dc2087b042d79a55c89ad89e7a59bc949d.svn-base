//
//  CustomSearchView.m
//  TableTest
//
//  Created by caijingpeng.haowu on 14-11-17.
//  Copyright (c) 2014年 caijingpeng.haowu. All rights reserved.
//

#import "CustomSearchView.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

#define ITEM_HEIGHT         45
#define ITEM_TAG            1001

@interface CustomSearchView()
{
    UIView *searchBackView;
    UIView *tableBackView;
    int selectedSection;
    NSString *title ;
    
    UITableView *_searchTV;
    UITableView *_subSearchTV;
    BOOL _isHas;
    int subSelectedSection;
    
    NSString *zoneId;
    NSString *plateId;
    
    UIControl *ctrl;
}
@end

@implementation CustomSearchView
@synthesize searchItems;
@synthesize defaultTitles;
@synthesize itemArray;
@synthesize selIndexArr;
@synthesize subTitlesArr;
@synthesize delegate;
//@synthesize viewType;

- (id)initWithItems:(NSArray *)items andDefaultTitles:(NSArray *)dTitles
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    if (self)
    {
        self.backgroundColor = THEME_COLOR_BACKGROUND_2;
        self.searchItems = (NSMutableArray *)items;
        self.defaultTitles = (NSMutableArray *)dTitles;
        self.plateName = @"";
        if (defaultTitles == nil)
        {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0 ; i < items.count ; i++)
            {
                NSString *title1 = [[items objectAtIndex:i] objectAtIndex:0];
                [array addObject:title1];
            }
            self.defaultTitles = array;
        }
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5f)];
        upLine.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
        downLine.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:downLine];
        
        float width = self.frame.size.width / (float)items.count;
        
        selIndexArr = [NSMutableArray array];
        
        for (int i = 0; i < items.count; i++)
        {
            if (i != items.count - 1)
            {
                UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width, 0, 0.5f, self.frame.size.height)];
                seperateLine.backgroundColor = THEME_COLOR_LINE;
                [self addSubview:seperateLine];
            }
            
            NSString *title1;
            if ([self.defaultTitles count]>i) {
                 title1 = [self.defaultTitles objectAtIndex:i];
            }
            
            NSString *tmpStr = @"";
            for (int i = title1.length; i > 0; i--)
            {
                float tmpWidth = [self calculateWidthByString:[title1 substringWithRange:NSMakeRange(0, i)]];
                if (tmpWidth > width - 24)  //title放不下
                {
                    continue;
                }
                else
                {
                    if (i == title1.length)//title比较短 第一次就能放得下
                    {
                        tmpStr = title1;
                        break;
                    }
                    else    //title比较长 要多截一个字换成...
                    {
                        tmpStr = [NSString stringWithFormat:@"%@…",[title1 substringWithRange:NSMakeRange(0, i - 1)]];
                        break;
                    }
                }
            }
            float w = [self calculateWidthByString:tmpStr];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
            [button setTitle:tmpStr forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
//            [button setTitleColor:TITLE_COLOR_66 forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_SMALL_SIZE_2];
            [button setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2, 0, -(w + 2))];
            button.tag = ITEM_TAG + i;
            [button addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.textColor = [UIColor blackColor];
            [self addSubview:button];
            [selIndexArr addObject:@"0"];
        }
    }
    return self;
}

- (id)initWithItems:(NSArray *)items andDefaultTitles:(NSArray *)dTitles hasSubTitles:(BOOL)isHas{
    
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    _isHas = isHas;
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        searchItems = (NSMutableArray *)items;
        defaultTitles = (NSMutableArray *)dTitles;
        
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5f)];
        upLine.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
        downLine.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:downLine];
        
        float width = self.frame.size.width / (float)items.count;
        
        selIndexArr = [NSMutableArray array];
        
        for (int i = 0; i < items.count; i++)
        {
            if (i != items.count - 1)
            {
                UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width, 0, 0.5f, 35)];
                seperateLine.backgroundColor = THEME_COLOR_LINE;
                [self addSubview:seperateLine];
            }
             NSString *title1 = [self.defaultTitles objectAtIndex:i];
            
            float width = self.frame.size.width / (float)self.searchItems.count;
            
            NSString *tmpStr = @"";
            for (int i = title1.length; i > 0; i--)
            {
                float tmpWidth = [self calculateWidthByString:[title1 substringWithRange:NSMakeRange(0, i)]];
                if (tmpWidth > width - 24)  //title放不下
                {
                    continue;
                }
                else
                {
                    if (i == title1.length)//title比较短 第一次就能放得下
                    {
                        tmpStr = title1;
                        break;
                    }
                    else    //title比较长 要多截一个字换成...
                    {
                        tmpStr = [NSString stringWithFormat:@"%@…",[title1 substringWithRange:NSMakeRange(0, i - 1)]];
                        break;
                    }
                }
            }
            
            float w = [self calculateWidthByString:tmpStr];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
            [button setTitle:tmpStr forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:TITLE_COLOR_66 forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_SMALL_SIZE_2];
            button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [button setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2, 0, -(w + 2))];
            button.tag = ITEM_TAG + i;
            [button addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:button];
            
            [selIndexArr addObject:@"0"];
        }
    }
    return self;
}



//add by gusheng

- (id)initWithItems:(NSArray *)items andCustomerDefaultTitles:(NSArray *)dTitles hasSubTitles:(BOOL)isHas height:(CGFloat)height{
    
    self = [super initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 0)];
    _isHas = isHas;
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        searchItems = (NSMutableArray *)items;
        defaultTitles = (NSMutableArray *)dTitles;
        
        float width = self.frame.size.width / (float)items.count;
        
        selIndexArr = [NSMutableArray array];
        
        for (int i = 0; i < items.count; i++)
        {
            if (i != items.count - 1)
            {
                UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * width, 0, 0.5f, 35)];
                seperateLine.backgroundColor = THEME_COLOR_LINE;
                //[self addSubview:seperateLine];
            }
            //NSString *title1 = [self.defaultTitles objectAtIndex:i];
            
            //float width = self.frame.size.width / (float)self.searchItems.count;
            
            NSString *tmpStr = @"";
            float w = [self calculateWidthByString:tmpStr];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
            [button setTitle:tmpStr forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:TITLE_COLOR_66 forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_SMALL_SIZE_2];
            button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [button setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2, 0, -(w + 2))];
            button.tag = ITEM_TAG + i;
            [button addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //[self addSubview:button];
            
            [selIndexArr addObject:@"0"];
        }
    }
    return self;
}
//end by gusheng
- (void)fillSubtitlesWithArray:(NSArray *)arr{
    self.subTitlesArr = [NSMutableArray arrayWithArray:arr];
    [_subSearchTV reloadData];
}

- (float)calculateWidthByString:(NSString *)str
{
    UIFont *font = [UIFont fontWithName:FONTNAME size:TITLE_SMALL_SIZE_2];
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size.width;
    }
    else
    {
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(1000, 30) lineBreakMode:NSLineBreakByWordWrapping];
        return size.width;
    }
    return 0;
}

- (void)removeBackView{
    [self hideSearchBackView];
}

- (void)doSelect:(UIButton *)sender
{
    [sender setImage:[UIImage imageNamed:@"filter_up1"] forState:UIControlStateNormal];
    if ((ITEM_TAG + selectedSection) != sender.tag)
    {
        if (searchBackView != nil)
        {
            [searchBackView removeFromSuperview];
            searchBackView = nil;
        }
        
        UIButton *preSelBtn = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
        [preSelBtn setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
    }
    
    if ((ITEM_TAG + selectedSection) == sender.tag && searchBackView != nil)
    {
        [self hideSearchBackView];
        return;
    }
    
    selectedSection = sender.tag % ITEM_TAG;
    itemArray = [self.searchItems objectAtIndex:selectedSection];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, CONTENT_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
    [self.superview addSubview:view];
    
    searchBackView = view;
    
    UIView *tBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 0)];
    tBackView.backgroundColor = [UIColor clearColor];
    tBackView.layer.masksToBounds = YES;
    [view addSubview:tBackView];
    
    
    tableBackView = tBackView;
    
    _searchTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, MIN(CONTENT_HEIGHT - (self.frame.origin.y + self.frame.size.height) - 40, ITEM_HEIGHT * itemArray.count)) style:UITableViewStylePlain];
    if (_isHas && sender.tag == ITEM_TAG) {
        _searchTV.frame = CGRectMake(_searchTV.frame.origin.x, _searchTV.frame.origin.y, view.frame.size.width / 2.0f, MIN(([UIScreen mainScreen].bounds.size.height - 64 - 49 - 35), (ITEM_HEIGHT * (itemArray.count + 1))));
//        _searchTV.frame = CGRectMake(_searchTV.frame.origin.x, _searchTV.frame.origin.y, view.frame.size.width / 2.0f, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 35);
    }
    _searchTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchTV.delegate = self;
    _searchTV.dataSource = self;
    [tableBackView addSubview:_searchTV];
    
    if (_isHas) {
        _subSearchTV = [[UITableView alloc] initWithFrame:CGRectMake(view.frame.size.width / 2.0f, 0, view.frame.size.width / 2.0f, MIN(CONTENT_HEIGHT - (self.frame.origin.y + self.frame.size.height) - 40, _searchTV.frame.size.height)) style:UITableViewStylePlain];
        _subSearchTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subSearchTV.delegate = self;
        _subSearchTV.dataSource = self;
        [tableBackView addSubview:_subSearchTV];
    }
    
    ctrl = [[UIControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_searchTV.frame), CGRectGetWidth(_searchTV.frame), 1000)];
    [ctrl addTarget:self action:@selector(hideSearchBackView) forControlEvents:UIControlEventTouchUpInside];
    [searchBackView addSubview:ctrl];
    
    [self showSearchBackView:sender.tag];
    
    if (subTitlesArr.count > 0)
    {
        [self reloadSubTableFrame];
    }
}

- (void)reloadSubTableFrame
{
    _subSearchTV.frame = CGRectMake(self.frame.size.width / 2.0f,
                                    0,
                                    self.frame.size.width / 2.0f,
                                    MIN(([UIScreen mainScreen].bounds.size.height - 64 - 49 - 35), (subTitlesArr.count + 1) * ITEM_HEIGHT));
    
    CGRect frame = tableBackView.frame;
    frame.size.height = MAX(_searchTV.frame.size.height, _subSearchTV.frame.size.height);
    tableBackView.frame = frame;
    
    ctrl.frame = CGRectMake(0, CGRectGetHeight(tableBackView.frame), CGRectGetWidth(tableBackView.frame), 1000);
}

- (void)showSearchBackView:(int)itemTag
{
    [UIView animateWithDuration:0.3f animations:^{
        
        searchBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
        CGRect frame = tableBackView.frame;
        if (itemTag == ITEM_TAG)
        {
            frame.size.height = MIN(CONTENT_HEIGHT - (self.frame.origin.y + self.frame.size.height) - 40, ITEM_HEIGHT * (itemArray.count + 1));
        }
        else
        {
            frame.size.height = MIN(CONTENT_HEIGHT - (self.frame.origin.y + self.frame.size.height) - 40, ITEM_HEIGHT * itemArray.count);
        }
        tableBackView.frame = frame;
        
    }completion:^(BOOL finished) {
        
    }];
}

- (void)hideSearchBackView
{
    UIButton *selBtn = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
    [selBtn setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3f animations:^{
        searchBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        CGRect frame = tableBackView.frame;
        frame.size.height = 0;
        tableBackView.frame = frame;
        
    }completion:^(BOOL finished) {
        [searchBackView removeFromSuperview];
        searchBackView = nil;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_searchTV] && selectedSection == 0 && _isHas)
    {
        return itemArray.count + 1;
    }
    else if([tableView isEqual:_searchTV])
    {
        return itemArray.count;
    }
    if (zoneId.length == 0) {
        return subTitlesArr.count;
    }
    int selRow = [[selIndexArr pObjectAtIndex:selectedSection] intValue]; // 第一列选择 行数
    if (subTitlesArr.count > 0 || selRow > 0)
    {
        return subTitlesArr.count + 1;
    }
    
    return subTitlesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_SMALL_SIZE_2];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, ITEM_HEIGHT - 0.5f, tableView.frame.size.width, 0.5f)];
    [cell.contentView addSubview:line];
    
    if ([tableView isEqual:_searchTV])
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        cell.selectedBackgroundView = view;
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        view1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        cell.backgroundView = view1;
    }
    else
    {
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        view1.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
        cell.backgroundView = view1;
    }
    
    if ([tableView isEqual:_searchTV])
    {
        if (indexPath.row == 0 && selectedSection == 0)
        {
             cell.textLabel.text = @"不限";
            if (_isHas == NO) {
                line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
                view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
                cell.backgroundView = view;
            }
        }
        else
        {
            NSString *selectedRow = [selIndexArr objectAtIndex:selectedSection];
            
            if (_isHas && selectedSection == 0)
            {
                HWSearchAreaModel *model = [itemArray objectAtIndex:indexPath.row - 1];
                cell.textLabel.text = model.area_name;
            }else
            {
                if ([[itemArray objectAtIndex:indexPath.row]isKindOfClass:[HWSearchAreaModel class]])
                {
                    HWSearchAreaModel *model = [itemArray objectAtIndex:indexPath.row-1];
                    cell.textLabel.text = model.area_name;
                }
                else
                {
                     cell.textLabel.text = [itemArray objectAtIndex:indexPath.row];
                }
               
            }
            if (indexPath.row == selectedRow.intValue)
            {
                line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
                view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
                cell.backgroundView = view;
            }
            else
            {
                cell.textLabel.textColor = [UIColor blackColor];
                line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
            }
        }
    }
    else
    {
        
        if (zoneId.length > 0)
        {
            if (indexPath.row == 0)
            {
                cell.textLabel.text = @"不限";
            }
            else
            {
                HWSearchPlateModel *plateMode = [subTitlesArr objectAtIndex:indexPath.row - 1];
                cell.textLabel.text = plateMode.name;
            }
        }
        else
        {
            HWSearchPlateModel *plateMode = [subTitlesArr objectAtIndex:indexPath.row];
            cell.textLabel.text = plateMode.name;
        }
        if (indexPath.row == subSelectedSection)
        {
            line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
            cell.backgroundView = view;
        }
        else
        {
            cell.textLabel.textColor = [UIColor blackColor];
            line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    line.image = [Utility imageWithColor:THEME_COLOR_LINE _size:CGSizeMake(1, 1)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ITEM_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_searchTV])
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        subSelectedSection = 0;
        
       // [self.delegate passValue:@"" withIndex:[NSString stringWithFormat:@"%d",selectedSection]];
        if (indexPath.row == 0 && _isHas && selectedSection == 0)
        {
            [selIndexArr replaceObjectAtIndex:selectedSection withObject:[NSString stringWithFormat:@"%d", indexPath.row]];
            float w = [self calculateWidthByString:defaultTitles[0]];
            UIButton *button = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
            [button setTitle:defaultTitles[0] forState:UIControlStateNormal];
            self.plateName = defaultTitles[0];
            [button setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 4)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2 , 0, -(w + 2))];
            [tableView reloadData];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.delegate customerSearchView:self passZone:@"" plateId:@""];
            
            [self hideSearchBackView];
            
            subTitlesArr = nil;
            return;
        }
        else if (_isHas && selectedSection == 0 && indexPath.row != 0)
        {
            HWSearchAreaModel *model = [itemArray objectAtIndex:indexPath.row - 1];
            zoneId = model.area_id;
            subTitlesArr = model.plates;
            
            
            [self reloadSubTableFrame];
            
            
        }
        else
        {
            [self.delegate customerSearchView:self passValue:[NSString stringWithFormat:@"%ld",(long)indexPath.row] withIndex:[NSString stringWithFormat:@"%d",selectedSection]];
            [self hideSearchBackView];
        }
        
        NSString *selectedRow = [NSString stringWithFormat:@"%d", (int)indexPath.row];
        [selIndexArr replaceObjectAtIndex:selectedSection withObject:selectedRow];
        
        title = cell.textLabel.text;
        if (indexPath.row == 0) {
            title = [defaultTitles objectAtIndex:selectedSection];
            subTitlesArr = nil;
            [_subSearchTV reloadData];
        }
        
        [_subSearchTV reloadData];
        
        float width = self.frame.size.width / (float)self.searchItems.count;
        
        NSString *tmpStr = @"";
        for (int i = title.length; i > 0; i--)
        {
            float tmpWidth = [self calculateWidthByString:[title substringWithRange:NSMakeRange(0, i)]];
            if (tmpWidth > width - 24)  //title放不下
            {
                continue;
            }
            else
            {
                if (i == title.length)//title比较短 第一次就能放得下
                {
                    tmpStr = title;
                    break;
                }
                else    //title比较长 要多截一个字换成...
                {
                    tmpStr = [NSString stringWithFormat:@"%@…",[title substringWithRange:NSMakeRange(0, i - 1)]];
                    break;
                }
            }
        }
        
        float w = [self calculateWidthByString:tmpStr];
        UIButton *button = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
        [button setTitle:tmpStr forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2 , 0, -(w + 2))];
        [tableView reloadData];
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else
    {
        if (indexPath.row == 0) 
        {
            NSString *selectedRow = [selIndexArr objectAtIndex:selectedSection];
            HWSearchAreaModel *model = [itemArray objectAtIndex:selectedRow.intValue - 1];
            
            subSelectedSection = (int)indexPath.row;
            float w = [self calculateWidthByString:model.area_name];
            UIButton *button = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
            [button setTitle:model.area_name forState:UIControlStateNormal];
            self.plateName = model.area_name;
            [button setImage:[UIImage imageNamed:@"filter_down1"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2 , 0, -(w + 2))];
            [self hideSearchBackView];
            [self.delegate customerSearchView:self passZone:zoneId plateId:@""];
            return;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        subSelectedSection = (int)indexPath.row;
        HWSearchPlateModel *plate = [subTitlesArr objectAtIndex:indexPath.row - 1];
        
        float width = self.frame.size.width / (float)self.searchItems.count;
        
        NSString *tmpStr = @"";
        for (int i = plate.name.length; i > 0; i--)
        {
            float tmpWidth = [self calculateWidthByString:[plate.name substringWithRange:NSMakeRange(0, i)]];
            if (tmpWidth > width - 24)  //title放不下
            {
                continue;
            }
            else
            {
                if (i == plate.name.length)//title比较短 第一次就能放得下
                {
                    tmpStr = plate.name;
                    break;
                }
                else    //title比较长 要多截一个字换成...
                {
                    tmpStr = [NSString stringWithFormat:@"%@…",[plate.name substringWithRange:NSMakeRange(0, i - 1)]];
                    break;
                }
            }
        }
        
        float w = [self calculateWidthByString:tmpStr];
        UIButton *button = (UIButton *)[self viewWithTag:(ITEM_TAG + selectedSection)];
        [button setTitle:tmpStr forState:UIControlStateNormal];
        self.plateName = plate.name;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 7)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, w + 2 , 0, -(w + 2))];
        [tableView reloadData];
        [self.delegate customerSearchView:self passZone:zoneId plateId:plate.plate_id];
        [self hideSearchBackView];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
