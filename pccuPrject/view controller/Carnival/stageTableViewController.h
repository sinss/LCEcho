//
//  stageTableViewController.h
//  SlyCool001
//
//  Created by sinss on 12/10/6.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "MHLazyTableImages.h"
#import "EGORefreshTableHeaderView.h"
#import "SBJSON.h"

@interface stageTableViewController : UITableViewController
<downloadStoreListProcess,MHLazyTableImagesDelegate, EGORefreshTableHeaderDelegate>
{
    MBProgressHUD *HUD;
    
    MHLazyTableImages *lazyImages;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
    BOOL _dataDidLoad;
    
    downloadStoreDelegate *downloadStage;
    NSArray *stageArray;
}

@property (nonatomic, retain) NSString *activityType;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
