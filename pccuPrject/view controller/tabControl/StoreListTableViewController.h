//
//  StoreListTableViewController.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "MHLazyTableImages.h"
#import "EGORefreshTableHeaderView.h"
#import "SBJSON.h"
#import "StoreTypeSelectViewController.h"
#import "DistanceSelectViewController.h"

@class StoreDetailTableViewController;

@interface StoreListTableViewController : UITableViewController
<downloadStoreListProcess,MHLazyTableImagesDelegate, EGORefreshTableHeaderDelegate,
StoreTypeSelectDelegate, distancePicker>
{
    downloadStoreDelegate *downloadStore;
    NSArray *storeArray;
    
    MBProgressHUD               *HUD;

    MHLazyTableImages           *lazyImages;
    
    EGORefreshTableHeaderView   *_refreshHeaderView;
    
	BOOL                         _reloading;
    BOOL                         _dataDidLoad;
    /*
     士林大地圖
     */
    
    /*
     過慮的店鋪清單
     */
    NSInteger *currentDistance;
    NSString *currentPredicateStr;
    NSString *currentPredicateDistance;
    NSArray *predictStoreArray;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
