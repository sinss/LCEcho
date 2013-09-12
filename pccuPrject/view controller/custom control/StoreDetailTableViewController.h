//
//  StoreDetailTableViewController.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "storeRateCell.h"
#import "FBConnect.h"

@class StoreTemp;
@class slMapViewController;
@interface StoreDetailTableViewController : UITableViewController
<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate,FBLoginDialogDelegate, storeRateDelegate>
{
    NSArray *groupArray;
    NSArray *detailArray;
    StoreTemp *currentStore;
    
    CLLocation *currLocation;
    NSString *currAddress;
    /*
     士林大地圖
     */
    slMapViewController *mapView;
    /*
     facebook
     */
    Facebook *facebook;
}

@property (nonatomic, retain) StoreTemp *currentStore;
@property (nonatomic, retain) CLLocation *currLocation;
@property (nonatomic, retain) NSString *currAddress;

@end
