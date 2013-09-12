//
//  activityRecord.h
//  SlyCool001
//
//  Created by sinss on 12/10/3.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface activityRecord : NSObject
{
    NSString *aID;
    NSString *aType;
    NSString *aTitle;
    NSString *aImageUrl;
    NSString *aLocationDesc;
    NSString *aIntroduction;
}
@property (nonatomic, retain) NSString *aID;
@property (nonatomic, retain) NSString *aType;
@property (nonatomic, retain) NSString *aTitle;
@property (nonatomic, retain) NSString *aImageUrl;
@property (nonatomic, retain) NSString *aLocationDesc;
@property (nonatomic, retain) NSString *aIntroduction;

@end
