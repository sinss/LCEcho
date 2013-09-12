//
//  pccuMediaRecord.h
//  pccuPrject
//
//  Created by sinss on 12/11/11.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    pccuMediaType1 = 0,
    pccuMediaType2 = 1,
};

@interface pccuMediaRecord : NSObject
{
    NSString *mNo;
    NSString *mImageUrl;
    NSString *mTitle;
    NSString *mSubTitle;
    NSString *mTitle2;
    NSString *mSubTitle2;
    NSString *mMovieUrl;
    NSString *mContent;
    NSString *mAdvertise;
}
@property (nonatomic, retain) NSString *mNo;
@property (nonatomic, retain) NSString *mImageUrl;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;
@property (nonatomic, retain) NSString *mTitle2;
@property (nonatomic, retain) NSString *mSubTitle2;
@property (nonatomic, retain) NSString *mMovieUrl;
@property (nonatomic, retain) NSString *mContent;
@property (nonatomic, retain) NSString *mAdvertise;


@end
