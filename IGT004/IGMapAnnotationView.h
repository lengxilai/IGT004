//
//  IGMapAnnotationView.h
//  IGT004
//
//  Created by wang chong on 12-9-4.
//  Copyright (c) 2012年 ntt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGGEOInfo.h"
#import "IGCommonDefine.h"
#import "Restaurant.h"
#import "IGBasicAnnotation.h"
@interface IGMapAnnotationView : UIView{
    Restaurant *res;
}
-(id)initWithAnnotation:(id <MKAnnotation>)annotation;
-(Restaurant *)restaurant;
@end
