//
//  slyCoolA.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/26.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "slyCoolA.h"


@implementation slyCoolA
@synthesize ANo,ATitle,ASubTitle,ASubA,AConA,ASubB,AConB,ASubC,AConC,APicA,APicB,APicC,APicD,AStoreID,ASubCon,AExpireDate,ADistance, ExInfo, ExInfoURL, FBURL;

- (void)dealloc
{
    [ANo release], ANo = nil;
    [ATitle release], ATitle = nil;
    [ASubTitle release], ASubTitle = nil;
    [ASubA release], ASubA = nil;
    [AConA release], AConA = nil;
    [ASubB release], ASubB = nil;
    [AConB release], AConB = nil;
    [ASubC release], ASubC = nil;
    [AConC release], AConC = nil;
    [APicA release], APicA = nil;
    [APicB release], APicB = nil;
    [APicC release], APicC = nil;
    [AStoreID release], AStoreID = nil;
    [ASubCon release], ASubCon = nil;
    [AExpireDate release], AExpireDate = nil;
    [ADistance release], ADistance = nil;
    [ExInfo release], ExInfo = nil;
    [ExInfoURL release], ExInfoURL = nil;
    [FBURL release], FBURL = nil;
    [super dealloc];
}
@end
