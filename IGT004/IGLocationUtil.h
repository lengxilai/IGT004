//
//  IGLocationUtil.h
//  IGT004
//
//  Created by wang chong on 12-9-6.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGLocationUtil : NSObject{
    double l_locationLatitude;
    double l_locationLongitude;
}
@property(nonatomic,assign)double l_locationLatitude;
@property(nonatomic,assign)double l_locationLongitude;
+(IGLocationUtil*)locationUtil;
@end
