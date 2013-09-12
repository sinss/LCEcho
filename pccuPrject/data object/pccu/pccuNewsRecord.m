//
//  pccuNewsRecord.m
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuNewsRecord.h"

@implementation pccuNewsRecord
@synthesize nNo, nTitle, nSubTitle, nImageUrl, nContentTitle, nContent,nContentTitle2, nContent2, nImageUrl2, otherUrl;

- (void)dealloc
{
    [nNo release], nNo = nil;
    [nTitle release], nTitle = nil;
    [nSubTitle release], nSubTitle = nil;
    [nImageUrl release], nImageUrl = nil;
    [nContentTitle release], nContentTitle = nil;
    [nContent release], nContent = nil;
    [nContentTitle2 release], nContentTitle2 = nil;
    [nContent2 release], nContent2 = nil;
    [nImageUrl2 release], nImageUrl2 = nil;
    [otherUrl release], otherUrl = nil;
    [super dealloc];
}

@end
