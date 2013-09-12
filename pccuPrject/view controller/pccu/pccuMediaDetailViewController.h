//
//  pccuMediaDetailViewController.h
//  pccuPrject
//
//  Created by sinss on 12/11/15.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pccuMediaRecord;

@interface pccuMediaDetailViewController : UIViewController
{
    pccuMediaRecord *currentMediaRecord;
    NSUInteger pccuMediaType;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subTitleLabel;
    IBOutlet UIButton *movieButton;
    IBOutlet UIButton *broadcastButton;
    IBOutlet UITextView *contentTextView;
    IBOutlet UIImageView *bannerImageView;
}

@property (nonatomic, retain) pccuMediaRecord *currentMediaRecord;

@property (assign) NSUInteger pccuMediaType;

- (IBAction)movieButtonPress:(id)sender;
- (IBAction)broadcastButtonPress:(id)sender;


@end
