//
//  IGJsonUtil.h
//  IGT004
//
//  Created by 鹏 李 on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "IGRestaurantUtil.h"

typedef enum {
    json_start,
    json_ing,
    json_over,
    json_error,
} json_state;


@interface IGJsonUtil : NSObject<SBJsonStreamParserAdapterDelegate>{
    NSURLConnection *theConnection;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
}

// 处理状态
@property (nonatomic)json_state state;

-(id)init;
-(void)getNewData;
@end
