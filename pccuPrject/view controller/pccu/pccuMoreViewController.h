//
//  pccuMoreViewController.h
//  pccuPrject
//
//  Created by sinss on 12/10/28.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pccuMoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *groupArray;
    NSArray *ecoArray;
    NSArray *thankArray;
    NSArray *otherArray;
    IBOutlet UITableView *aTableView;
}

@end
