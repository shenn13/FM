//
//  FMDetailTableViewCell.h
//  fm
//
//  Created by shen on 17/3/7.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMDetailModel;

@interface FMDetailTableViewCell : UITableViewCell

@property (nonatomic,strong)FMDetailModel *FMDetailModel;

@property (strong, nonatomic) UIImageView *headImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
