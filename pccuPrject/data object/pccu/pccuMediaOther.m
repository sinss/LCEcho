//
//  pccuMediaOther.m
//  pccuPrject
//
//  Created by sinss on 12/11/12.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMediaOther.h"

@implementation pccuMediaOther
@synthesize mNo, mImageUrl, mTitle, mTitle2, mSubTitle, mSubTitle2, mContent, mContent2, mContent3, mContent4, mImageUrl2, mAdvitise, mImageContent;

- (void)dealloc
{
    [mNo release], mNo = nil;
    [mImageUrl2 release], mImageUrl2 = nil;
    [mImageUrl release], mImageUrl = nil;
    [mTitle release], mTitle = nil;
    [mTitle2 release], mTitle2 = nil;
    [mSubTitle release], mSubTitle = nil;
    [mSubTitle2 release], mSubTitle2 = nil;
    [mContent release], mContent = nil;
    [mContent2 release], mContent2 = nil;
    [mContent3 release], mContent3 = nil;
    [mContent4 release], mContent4 = nil;
    [mImageContent release], mImageContent = nil;
    [mAdvitise release], mAdvitise = nil;
    [super dealloc];
}

@end
