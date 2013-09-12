//
//  adRecord.m
//  SlyCool001
//
//  Created by sinss on 12/8/15.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "adRecord.h"

@implementation adRecord
@synthesize adContent, adImageUrl, adTitle, adNo, expireDate, contentUrl;

- (void)dealloc
{
    [adNo release], adNo = nil;
    [adContent release], adContent = nil;
    [adImageUrl release], adImageUrl = nil;
    [adTitle release], adTitle = nil;
    [expireDate release], expireDate = nil;
    [contentUrl release], contentUrl = nil;
    [super dealloc];
}

@end
