//
//  IGLocationUtil.m
//  IGT004
//
//  Created by wang chong on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGLocationUtil.h"

@implementation IGLocationUtil
static MKUserLocation *l_location;
+(void)setUserLocation:(MKUserLocation *)location{
    l_location = location;
}
+(MKUserLocation *)getUserLocation{
    return l_location;
}
@end
