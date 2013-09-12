//
//  pccuNewsTableViewController.h
//  pccuPrject
//
//  Created by sinss on 12/10/21.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "MHLazyTableImages.h"
#import "SBJSON.h"
#import "pccuNewsRecord.h"

@interface pccuNewsTableViewController : UITableViewController
<downloadStoreListProcess,MHLazyTableImagesDelegate>
{
    MBProgressHUD *HUD;
    
    MHLazyTableImages *lazyImages;
    
    downloadStoreDelegate *downloadPccuNews;
    NSArray *pccuNewsArray;
    pccuNewsType typeOfPccuNews;
}

@property (assign) pccuNewsType typeOfPccuNews;
@end
