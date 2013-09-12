//
//  stageRecord.m
//  SlyCool001
//
//  Created by sinss on 12/10/3.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "stageRecord.h"

@implementation stageRecord
@synthesize sID, sTitle, sImageUrl, sTime, sLocationDesc, sIntroduction, sOtherUrl;

- (void)dealloc
{
    [sID release], sID = nil;
    [sTitle release], sTitle = nil;
    [sImageUrl release], sImageUrl= nil;
    [sTime release], sTime = nil;
    [sLocationDesc release], sLocationDesc = nil;
    [sIntroduction release], sIntroduction = nil;
    [sOtherUrl release], sOtherUrl = nil;
    [super dealloc];
}

@end
