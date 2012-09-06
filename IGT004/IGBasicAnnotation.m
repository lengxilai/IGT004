//
//  IGBasicAnnotation.m
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import "IGBasicAnnotation.h"

@implementation IGBasicAnnotation
@synthesize coordinate, m_geoInfo;

- (NSString *)subtitle
{
	return m_geoInfo.m_name;
}
- (NSString *)title
{
	return m_geoInfo.m_description;
}
-(Restaurant *)restaurant{
    return m_geoInfo.res;
}
-(id)initWithGeoInfo:(IGGEOInfo *) geoInfo
{
    m_geoInfo = geoInfo;
    
	coordinate = geoInfo.m_coordinate2D;
    res = geoInfo.res;
	return self;
}
@end
