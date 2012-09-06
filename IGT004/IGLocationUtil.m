//
//  IGLocationUtil.m
//  IGT004
//
//  Created by wang chong on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGLocationUtil.h"

@implementation IGLocationUtil
static CLLocation *l_location;
+(void)setUserLocation:(CLLocation *)location{
    l_location = location;
}
+(CLLocation *)getUserLocation{
    return l_location;
}
@end
