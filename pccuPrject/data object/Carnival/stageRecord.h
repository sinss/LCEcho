//
//  stageRecord.h
//  SlyCool001
//
//  Created by sinss on 12/10/3.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stageRecord : NSObject
{
    NSString *sID;
    NSString *sTitle;
    NSString *sImageUrl;
    NSString *sTime;
    NSString *sLocationDesc;
    NSString *sIntroduction;
    NSString *sOtherUrl;
}
@property (nonatomic, retain) NSString *sID;
@property (nonatomic, retain) NSString *sTitle;
@property (nonatomic, retain) NSString *sImageUrl;
@property (nonatomic, retain) NSString *sTime;
@property (nonatomic, retain) NSString *sLocationDesc;
@property (nonatomic, retain) NSString *sIntroduction;
@property (nonatomic, retain) NSString *sOtherUrl;

@end
