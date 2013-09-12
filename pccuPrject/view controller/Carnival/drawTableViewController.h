//
//  drawTableViewController.h
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

@interface drawTableViewController : UITableViewController
<downloadStoreListProcess, EGORefreshTableHeaderDelegate>
{
    MBProgressHUD *HUD;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
    BOOL _dataDidLoad;
    
    downloadStoreDelegate *downloadDraw;
    NSArray *drawArray;
}

@property (nonatomic, retain) NSString *activityType;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
