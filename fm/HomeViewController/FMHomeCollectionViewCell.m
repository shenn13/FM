//
//  FMHomeCollectionViewCell.m
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "FMHomeCollectionViewCell.h"
#import "FMHomeModel.h"


@implementation FMHomeCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self){
        
        [self addSubviews];
        
    }else{
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    
    return self;
}


-(void)addSubviews{

    _thumbsImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.contentView.width, self.contentView.height - 30)];
    [self.contentView addSubview:_thumbsImage];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_thumbsImage.frame) + 10,self.contentView.width , 20)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
}


-(void)setModel:(FMHomeModel *)model{
    _model = model;
    
    _titleLabel.text = model.title;
    
    NSArray *imageArr = model.thumbs;
    
    [_thumbsImage sd_setImageWithURL:[NSURL URLWithString:[imageArr valueForKey:@"large_thumb"]] placeholderImage:nil];
}

@end
