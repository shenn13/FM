//
//  FMDetailTableViewCell.m
//  fm
//
//  Created by shen on 17/3/7.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "FMDetailTableViewCell.h"
#import "FMDetailModel.h"
@interface FMDetailTableViewCell (){
    
    UILabel *_titleLabel;
    UILabel *_upDataTimeLabel;
    
}
@end

@implementation FMDetailTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"FMDetailCell";
    FMDetailTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FMDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell addSubviews];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)addSubviews{
    
    _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
//    _headImage.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_headImage];
    
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 20)];
//    _titleLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_titleLabel];
    
    _upDataTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(_titleLabel.frame) + 10, 300, 20)];
//    _upDataTimeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_upDataTimeLabel];

}

-(void)setFMDetailModel:(FMDetailModel *)FMDetailModel{
    
    _FMDetailModel = FMDetailModel;
    _titleLabel.text = FMDetailModel.title;
    _upDataTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",FMDetailModel.update_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
