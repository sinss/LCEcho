//
//  activityRecord.m
//  SlyCool001
//
//  Created by sinss on 12/10/3.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "activityRecord.h"

@implementation activityRecord
@synthesize aID, aType, aTitle, aImageUrl, aLocationDesc, aIntroduction;

- (void)dealloc
{
    [aID release], aID = nil;
    [aType release], aType = nil;
    [aTitle release], aTitle = nil;
    [aImageUrl release], aImageUrl = nil;
    [aLocationDesc release], aLocationDesc = nil;
    [aIntroduction release], aIntroduction = nil;
    [super dealloc];
}

@end
