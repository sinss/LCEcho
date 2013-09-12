//
//  movieRecord.h
//  SlyCool001
//
//  Created by sinss on 12/10/4.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface movieRecord : NSObject
{
    NSString *mID;
    NSString *mTitle;
    NSString *mImageUrl;
    NSString *mMovieUrl;
    NSString *mDirector;
    NSString *mTeamDesc;
    NSString *mIntroduction;
    NSString *mOtherUrl;
}
@property (nonatomic, retain) NSString *mID;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mImageUrl;
@property (nonatomic, retain) NSString *mMovieUrl;
@property (nonatomic, retain) NSString *mDirector;
@property (nonatomic, retain) NSString *mTeamDesc;
@property (nonatomic, retain) NSString *mIntroduction;
@property (nonatomic, retain) NSString *mOtherUrl;

@end
