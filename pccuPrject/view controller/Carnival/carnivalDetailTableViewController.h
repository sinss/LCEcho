//
//  carnivalDetailTableViewController.h
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

@class activityRecord, stageRecord, drawRecord, movieRecord;
@interface carnivalDetailTableViewController : UITableViewController
{
    NSArray *groupArray;
    NSArray *informationArray;
    NSArray *contentArray;
    activityRecord *currentActivity;
    stageRecord *currentStage;
    movieRecord *currentMovie;
    carnivalDetailType detailType;
}

@property (nonatomic, retain) activityRecord *currentActivity;
@property (nonatomic, retain) stageRecord *currentStage;
@property (nonatomic, retain) movieRecord *currentMovie;
@property (assign) carnivalDetailType detailType;


@end
