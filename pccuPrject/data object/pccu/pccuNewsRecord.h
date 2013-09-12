//
//  pccuNewsRecord.h
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    pccuNewsType1 = 0,
    pccuNewsType2 = 1,
    pccuNewsType3 = 2,
    pccuNewsType4 = 3,
    pccuNewsType5 = 4,
    pccuNewsType6 = 5,
    pccuNewsType7 = 6,
    pccuNewsType8 = 7,
};
typedef NSUInteger pccuNewsType;

@interface pccuNewsRecord : NSObject
{
    NSString *nNo;
    NSString *nTitle;
    NSString *nSubTitle;
    NSString *nImageUrl;
    NSString *nContentTitle;
    NSString *nContent;
    NSString *nContentTitle2;
    NSString *nContent2;
    NSString *nImageUrl2;
    NSString *otherUrl;
}
@property (nonatomic, retain) NSString *nNo;
@property (nonatomic, retain) NSString *nTitle;
@property (nonatomic, retain) NSString *nSubTitle;
@property (nonatomic, retain) NSString *nImageUrl;
@property (nonatomic, retain) NSString *nContentTitle;
@property (nonatomic, retain) NSString *nContent;
@property (nonatomic, retain) NSString *nContentTitle2;
@property (nonatomic, retain) NSString *nContent2;
@property (nonatomic, retain) NSString *nImageUrl2;
@property (nonatomic, retain) NSString *otherUrl;


@end
