//
//  FMHomeModel.h
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol FMPodcastersProtocol <NSObject>
@end

@interface FMPodcastersModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*avatar;
@property (nonatomic, strong) NSString <Optional>*award_open;
//@property (nonatomic, strong) NSString <Optional>*birthday;
@property (nonatomic, strong) NSString <Optional>*fan_num;
@property (nonatomic, strong) NSString <Optional>*Podcastersid;
@property (nonatomic, strong) NSString <Optional>*location;
@property (nonatomic, strong) NSString <Optional>*nickname;
@property (nonatomic, strong) NSString <Optional>*sex;
@property (nonatomic, strong) NSString <Optional>*signature;
@property (nonatomic, strong) NSString <Optional>*sns_open;
@property (nonatomic, strong) NSString <Optional>*user_system_id;
@property (nonatomic, strong) NSString <Optional>*weibo_id;
@property (nonatomic, strong) NSString <Optional>*weibo_name;
@end


@protocol FMHomeDetailProtocol <NSObject>
@end
@interface FMHomeDetailModel : JSONModel

@property (nonatomic,strong)  NSArray <Optional,FMPodcastersProtocol> *podcasters;
@property (nonatomic, strong) NSString <Optional>*program_count;
@end





@protocol FMHomeModel <NSObject>
@end

@interface FMHomeModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*auto_play;
@property (nonatomic, strong) NSString <Optional>*category_id;
@property (nonatomic, strong) NSString <Optional>*chatgroup_id;
@property (nonatomic, strong) NSString <Optional>*id;
@property (nonatomic, strong) NSString <Optional>*is_finished;
@property (nonatomic, strong) NSString <Optional>*latest_program;
@property (nonatomic, strong) NSString <Optional>*link_id;
@property (nonatomic, strong) NSString <Optional>*record_enabled;
//@property (nonatomic, strong) NSString <Optional>*sale_props;
@property (nonatomic, strong) NSString <Optional>*sale_type;
@property (nonatomic, strong) NSString <Optional>*star;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*type;
@property (nonatomic, strong) NSString <Optional>*update_time;
@property (nonatomic,strong)  NSArray <Optional>*thumbs;
@property (nonatomic,strong)  FMHomeDetailModel <Optional,FMHomeDetailProtocol>*detailModel;

@end


//
//@interface FMHomeModel : NSObject
//
//@property (nonatomic, strong) NSString *auto_play;
//@property (nonatomic, strong) NSString *category_id;
//@property (nonatomic, strong) NSString *chatgroup_id;
//@property (nonatomic, strong) NSString *id;
//@property (nonatomic, strong) NSString *is_finished;
//@property (nonatomic, strong) NSString *latest_program;
//@property (nonatomic, strong) NSString *link_id;
//@property (nonatomic, strong) NSString *record_enabled;
//@property (nonatomic, strong) NSString *sale_props;
//@property (nonatomic, strong) NSString *sale_type;
//@property (nonatomic, strong) NSString *star;
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *type;
//@property (nonatomic, strong) NSString *update_time;
//@property (nonatomic,strong)  NSArray *thumbs;
//@property (nonatomic,strong)  NSArray *detail;
//@end






