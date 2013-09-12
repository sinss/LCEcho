//
//  drawRecord.m
//  SlyCool001
//
//  Created by sinss on 12/10/4.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "drawRecord.h"

@implementation drawRecord
@synthesize dTitle, dUrl, dId;

- (void)dealloc
{
    [dId release], dId = nil;
    [dTitle release], dTitle= nil;
    [dUrl release], dUrl = nil;
    [super dealloc];
}

@end
