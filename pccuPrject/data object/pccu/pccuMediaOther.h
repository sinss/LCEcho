//
//  pccuMediaOther.h
//  pccuPrject
//
//  Created by sinss on 12/11/12.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    pccuMediaOtherType1 = 0,
    pccuMediaOtherType2 = 1,
};

@interface pccuMediaOther : NSObject
{
    NSString *mNo;
    NSString *mImageUrl;
    NSString *mTitle;
    NSString *mSubTitle;
    NSString *mTitle2;
    NSString *mSubTitle2;
    NSString *mContent;
    NSString *mContent2;
    NSString *mContent3;
    NSString *mContent4;
    NSString *mImageUrl2;
    NSString *mImageContent;
    NSString *mAdvitise;
}
@property (nonatomic, retain) NSString *mNo;
@property (nonatomic, retain) NSString *mImageUrl;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;
@property (nonatomic, retain) NSString *mTitle2;
@property (nonatomic, retain) NSString *mSubTitle2;
@property (nonatomic, retain) NSString *mContent;
@property (nonatomic, retain) NSString *mContent2;
@property (nonatomic, retain) NSString *mContent3;
@property (nonatomic, retain) NSString *mContent4;
@property (nonatomic, retain) NSString *mImageUrl2;
@property (nonatomic, retain) NSString *mImageContent;
@property (nonatomic, retain) NSString *mAdvitise;

@end
