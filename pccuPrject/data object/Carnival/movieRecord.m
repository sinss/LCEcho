//
//  movieRecord.m
//  SlyCool001
//
//  Created by sinss on 12/10/4.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import "movieRecord.h"

@implementation movieRecord
@synthesize mID, mTitle, mImageUrl, mMovieUrl, mDirector, mTeamDesc, mIntroduction, mOtherUrl;

- (void)dealloc
{
    [mID release], mID = nil;
    [mTitle release], mTitle = nil;
    [mImageUrl release], mImageUrl = nil;
    [mMovieUrl release], mMovieUrl = nil;
    [mDirector release], mDirector = nil;
    [mTeamDesc release], mTeamDesc = nil;
    [mIntroduction release], mOtherUrl = nil;
    [super dealloc];
}
@end
