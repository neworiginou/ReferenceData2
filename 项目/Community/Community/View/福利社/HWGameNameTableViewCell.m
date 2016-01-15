//
//  HWGameNameTableViewCell.m
//  Community
//
//  Created by WeiYuanlin on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人全部游戏推广页面tableviewcell
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释  请把此文件移到对应文件夹
//      魏远林 2015-01-16 创建文件
//      魏远林 2015-01-19 规范代码

#import "HWGameNameTableViewCell.h"

#define CellHeight 90.0f
@implementation HWGameNameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *headImgBackV = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 0, CellHeight - 5.0f, CellHeight)];
        headImgBackV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:headImgBackV];
        
        self.headImg = [[UIImageView alloc]init];
        self.headImg.frame = CGRectMake(10.0f, 15.0f, CellHeight - 2 * 15.0f, CellHeight - 2 * 15.0f);
        self.headImg.backgroundColor = IMAGE_DEFAULT_COLOR;
        self.headImg.contentMode = UIViewContentModeScaleAspectFit;
        self.headImg.layer.cornerRadius = 6;
        self.headImg.layer.masksToBounds = YES;
        [headImgBackV addSubview:self.headImg];
        
        UIView *gameNameBackV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImgBackV.frame), 0, kScreenWidth - 2 * 15.0f - CellHeight + 5.0f, CellHeight)];
        gameNameBackV.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:gameNameBackV];
        
        self.gameNameLabel = [[UILabel alloc]init];
        self.gameNameLabel.textColor = THEME_COLOR_SMOKE;
        self.gameNameLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [gameNameBackV addSubview:self.gameNameLabel];
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CellHeight)];
        backgroundView.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
        self.backgroundView = backgroundView;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15.0f, CellHeight - 0.5f, kScreenWidth - 2 * 15.0f, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 0, 0.5f, CellHeight)];
        leftLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 15.0f - 0.5f, 0, 0.5f, CellHeight)];
        rightLine.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:rightLine];
    }
    return self;
}

/**
 *	@brief	重新给cell上的View赋值以及重写坐标
 *
 *	@param 	model 	传入model
 *
 *	@return	N/A
 */
- (void)setCellViewFrame:(HWGameAllNameModel *)model
{
//    self.selectedBackgroundView = [[UIView alloc] init];
//    self.selectedBackgroundView.backgroundColor = THEME_COLOR_BACKGROUND_2;
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor whiteColor];
//    self.isNeedSelectMode = YES;
    __weak UIImageView *imageView = self.headImg;
//    NSString *str = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,model.gameImg,[HWUserLogin currentUserLogin].key];
//    NSLog(@"%@",str);
    [imageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.gameImg]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        NSLog(@"%@",[Utility imageDownloadWithMongoDbKey:model.gameImg]);
        if (error == nil)
        {
            self.headImg.image = image;
        }
        else
        {
            self.headImg.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
    }];

    self.gameNameLabel.text = model.gameName;
    [self.gameNameLabel sizeToFit];
    self.gameNameLabel.frame = CGRectMake(0, (CellHeight - self.gameNameLabel.frame.size.height) / 2.0f, self.gameNameLabel.frame.size.width, self.gameNameLabel.frame.size.height);
    self.gameNameLabel.textAlignment = NSTextAlignmentLeft;

}

+ (CGFloat)setCellHeight
{
    return CellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
