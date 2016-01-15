//
//  HWSearchBarView.h
//  SearchLocation
//
//  Created by caijingpeng.haowu on 14-6-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWSearchBarCell.h"

@class HWSearchBarView;

@protocol HWSearchBarViewDelegate <NSObject>

- (void)searchBar:(HWSearchBarView *)searchView textChange:(NSString *)text;

- (void)searchBar:(HWSearchBarView *)searchView didSelectSearchResult:(NSString *)text  villageId:(NSString *)villageIdStr flag:(BOOL)flag;
-(void)searchBarEnd;

- (void)searchViewHide;

@end

@interface HWSearchBarView : UIView<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UIImageView *_textBackgroundImageView;
    UITableView *_searchResultTV;
    UITextField *_searchTF;
    UIButton *_cancelButton;
    NSMutableArray *_dataSource;
    UIView *_searchBackView;
    BOOL cityOrCommunityFlag;
}

@property (nonatomic, assign)float frameMaxHeight;
@property (nonatomic, assign)id<HWSearchBarViewDelegate> delegate;
@property (nonatomic, strong)UITextField *_searchTF;
@property (nonatomic, copy)void(^searchKeyward)(NSString *keyward);
@property (nonatomic, assign)BOOL cityOrCommunityFlag;

- (BOOL)isFirstResponder;
- (void)setSearchResultData:(NSArray *)dataSource;
- (void)searchResignFirstResponder;
- (void)selected:(NSString *)selectStr;
- (void)setSearchBarPlaceholder:(NSString *)placeholder;
-(void)sendTextChange;
@end
