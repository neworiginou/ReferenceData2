//
//  DateCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "DateCell.h"
#define middleWith  Main_Screen_Width - 10 - 34
@implementation DateCell

- (void)awakeFromNib {
    // Initialization code

}

+ (NSString*)dateIndentifier
{
    return @"dateCell";
}

+ (DateCell*)dateCell
{
    NSArray  * array = [[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:nil options:nil];
    DateCell * cell = array[0];
    return cell;
}

- (DateCell*)configureWithDate:(DateModel*)date
{
    int j = 0;
    float y = 80.0;
    float space = middleWith;

    for (int i = 0; i < date.seriesArray.count; i++) {
        
        NSString * str = date.seriesArray[i];
        float width = [str widthWithFont:SYSTEMFONT(14) height:14];
        NSRange  range = NSMakeRange(0, str.length);
        
        if (space < width + 10 + 37) {
            
            j += 1;
            y = 80;
        }
      
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(y, 13 + (20 + 10)*j, width + 10, 20)];
        [btn.titleLabel setFont:SYSTEMFONT(14)];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage stretchImageWithName:@"bg_news_schedule_label_h9"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage stretchImageWithName:@"bg_news_schedule_label_n9"] forState:UIControlStateDisabled];
        
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:str];
        [attr addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)} range:range];
        [attr addAttributes:@{NSStrikethroughColorAttributeName:[UIColor grayColor]} range:range];
        [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:range];
        [attr addAttributes:@{NSFontAttributeName:SYSTEMFONT(14)} range:range];
        [btn setAttributedTitle:attr forState:UIControlStateDisabled];
        if (i == 2) {
            btn.enabled = NO;
        }
        
        y =  (width + 10) + 10 + y;
        space = middleWith - MaxX(btn);

        [self.middleView addSubview:btn];
    }
    
    
    _day.text = date.day;
    _weak.text = date.weekDay;
    _month.text = date.month;

    if (date.unfold) {
        [_expandBtn setBackgroundImage:IMAGENAME(@"btn_blue_up") forState:UIControlStateNormal];
        _dateView.backgroundColor = RGBCOLOR(0.133, 0.757, 0.988);
    }else{
        [_expandBtn setBackgroundImage:IMAGENAME(@"btn_gray_down") forState:UIControlStateNormal];
        _dateView.backgroundColor = RGBCOLOR(0.710, 0.710, 0.710);
    }
    
    return self;
}

+ (CGFloat)heightForCellWithDate:(DateModel *)date
{
    if (date.unfold) {
        
        int j = 0;
        float y = 80.0;
        float height = 0;
        float space = middleWith;
        
        for (int i = 0; i < date.seriesArray.count; i++) {
            
            NSString * str = date.seriesArray[i];
            float width = [str widthWithFont:SYSTEMFONT(14) height:14];

            if (space < width + 10 + 37) {
                
                j += 1;
                y = 80;
            }
        
            height = (20 + 10)*j + 13;
            
            y =  (width + 10) + 10 + y;
            
            space = middleWith - y - 10;
        }

        return MAX(90, height + 20 + 10);
    }
    
    return 90;
}

- (IBAction)didUnfold:(UIButton *)sender {
    
    //展开活着收起
    if ([_delegate respondsToSelector:@selector(unfoldCell:)]) {
        [_delegate unfoldCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
