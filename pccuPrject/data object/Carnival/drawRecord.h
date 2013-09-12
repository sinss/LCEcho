//
//  drawRecord.h
//  SlyCool001
//
//  Created by sinss on 12/10/4.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface drawRecord : NSObject
{
    NSString *dId;
    NSString *dTitle;
    NSString *dUrl;
}

@property (nonatomic, retain) NSString *dId;
@property (nonatomic, retain) NSString *dTitle;
@property (nonatomic, retain) NSString *dUrl;

@end
