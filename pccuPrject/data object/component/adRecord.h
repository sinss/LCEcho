//
//  adRecord.h
//  SlyCool001
//
//  Created by sinss on 12/8/15.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adRecord : NSObject
{
    NSString *adNo;
    NSString *adTitle;
    NSString *adContent;
    NSString *adImageUrl;
    NSString *expireDate;
    NSString *contentUrl;
}
@property (nonatomic, retain) NSString *adNo;
@property (nonatomic, retain) NSString *adTitle;
@property (nonatomic, retain) NSString *adContent;
@property (nonatomic, retain) NSString *adImageUrl;
@property (nonatomic, retain) NSString *expireDate;
@property (nonatomic, retain) NSString *contentUrl;

@end
