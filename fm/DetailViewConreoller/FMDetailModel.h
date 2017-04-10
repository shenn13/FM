//
//  FMDetailModel.h
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMUrlModel
@end

@interface FMUrlModel : JSONModel
@property (nonatomic, strong) NSString *bitrate;
@property (nonatomic, strong) NSString *file_path;
@property (nonatomic, strong) NSString *id;
@end


@protocol FMMediainfoModel
@end
@interface FMMediainfoModel : JSONModel
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *id;

@property (nonatomic,strong) NSArray<FMUrlModel> *bitrates_url;
@end

@interface FMDetailModel : JSONModel

@property (nonatomic, strong) NSString *chatgroup_id;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *original_fee;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *redirect_url;
@property (nonatomic, strong) NSString *sale_status;
@property (nonatomic, strong) NSString *sequence;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *update_time;

@property (nonatomic,strong) FMMediainfoModel *mediainfo;

@end
