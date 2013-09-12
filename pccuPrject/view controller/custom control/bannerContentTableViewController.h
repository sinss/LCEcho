//
//  bannerContentTableViewController.h
//  SlyCool001
//
//  Created by sinss on 12/8/27.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

@class adRecord;
@interface bannerContentTableViewController : UITableViewController
{
    adRecord *currentAdRecord;
    NSDictionary *titleDict;
    NSDictionary *contentDict;
}
@property (nonatomic, retain) adRecord *currentAdRecord;
@end
