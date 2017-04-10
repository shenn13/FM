//
//  FMHomeCollectionViewCell.h
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMHomeModel;
@class FMHomeDetailModel;
@interface FMHomeCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)FMHomeModel *model;

@property (strong, nonatomic) UIImageView *thumbsImage;
@property (strong, nonatomic) UILabel *titleLabel;

@end
