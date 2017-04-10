//
//  FMHomeModel.m
//  fm
//
//  Created by shen on 17/3/4.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "FMHomeModel.h"



@implementation FMPodcastersModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"Podcastersid"}];
}
@end


@implementation FMHomeDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end


@implementation FMHomeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"fmid"}];
}

@end
