//
//  pccuNewsDetailViewController.h
//  pccuPrject
//
//  Created by sinss on 12/11/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pccuNewsRecord;
@interface pccuNewsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *contentArray;
    pccuNewsRecord *currentPccuRecord;
    IBOutlet UITableView *aTableView;
}
@property (nonatomic, retain) pccuNewsRecord *currentPccuRecord;

@end
