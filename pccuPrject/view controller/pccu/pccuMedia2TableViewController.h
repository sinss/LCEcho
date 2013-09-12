//
//  pccuMedia2TableViewController.h
//  pccuPrject
//
//  Created by sinss on 12/11/11.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHLazyTableImages.h"
#import "downloadStoreDelegate.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"

@interface pccuMedia2TableViewController : UITableViewController <downloadStoreListProcess, MHLazyTableImagesDelegate>
{
    MBProgressHUD *HUD;
    MHLazyTableImages *lazyImages;
    downloadStoreDelegate *downloadMedia;
    
    NSArray *pccuMediaArray;
    NSUInteger pccuMediaType;
}

@property (nonatomic) NSUInteger pccuMediaType;

@end
