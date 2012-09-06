//
//  IGLocationUtil.m
//  IGT004
//
//  Created by wang chong on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGLocationUtil.h"

@implementation IGLocationUtil
static IGLocationUtil *staticLocationUtil;
@synthesize l_locationLatitude;
@synthesize l_locationLongitude;
+(IGLocationUtil*)locationUtil
{
    if (staticLocationUtil == nil) {
        staticLocationUtil = [[IGLocationUtil alloc] init];
        return staticLocationUtil;
    }else {
        return staticLocationUtil;
    }
}

@end
