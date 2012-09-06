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
@interface IGMapAnnotationView : UIView{

}
-(id)initWithAnnotation:(id <MKAnnotation>)annotation;
@end
