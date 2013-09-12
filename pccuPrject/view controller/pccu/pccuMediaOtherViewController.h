//
//  pccuMediaOtherViewController.h
//  pccuPrject
//
//  Created by sinss on 12/11/15.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pccuMediaOther;
@interface pccuMediaOtherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    pccuMediaOther *currentMediaRecord;
    NSUInteger pccuMediaType;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subTitleLabel;
    IBOutlet UITableView *contentTableView;
    IBOutlet UIImageView *bannerImageView;
}
@property (nonatomic, retain) pccuMediaOther *currentMediaRecord;
@property (assign) NSUInteger pccuMediaType;


@end
