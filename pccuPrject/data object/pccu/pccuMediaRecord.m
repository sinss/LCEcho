//
//  pccuMediaRecord.m
//  pccuPrject
//
//  Created by sinss on 12/11/11.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "pccuMediaRecord.h"

@implementation pccuMediaRecord
@synthesize mNo,mImageUrl, mTitle, mTitle2, mSubTitle, mSubTitle2, mContent, mMovieUrl, mAdvertise;

- (void)dealloc
{
    [mNo release], mNo = nil;
    [mTitle release], mTitle = nil;
    [mTitle2 release], mTitle2 = nil;
    [mSubTitle release], mSubTitle = nil;
    [mSubTitle2 release], mSubTitle2 = nil;
    [mContent release], mContent = nil;
    [mMovieUrl release], mMovieUrl = nil;
    [mAdvertise release], mAdvertise = nil;
    [super dealloc];
}

@end
