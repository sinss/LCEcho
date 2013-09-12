//
//  TopicListTableViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "MHLazyTableImages.h"
#import "EGORefreshTableHeaderView.h"


@interface TopicListTableViewController : UITableViewController
<downloadStoreListProcess, MHLazyTableImagesDelegate, EGORefreshTableHeaderDelegate>
{
    MBProgressHUD               *HUD;
    
    MHLazyTableImages           *lazyImages;
    
    EGORefreshTableHeaderView   *_refreshHeaderView;
    
	BOOL                         _reloading;
    BOOL                         _dataDidLoad;
    
    downloadStoreDelegate *downloadProcess;
    NSArray *topicArray;
    
}

@end
