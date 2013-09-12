//
//  moreTableViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"

@interface moreTableViewController : UITableViewController
<EGORefreshTableHeaderDelegate, downloadStoreListProcess>
{
    MBProgressHUD               *HUD;
    
    EGORefreshTableHeaderView   *_refreshHeaderView;
    
	BOOL                         _reloading;
    BOOL                         _dataDidLoad;
    
    downloadStoreDelegate *downloadProcess;
    NSArray *moreArray;
}

@end
