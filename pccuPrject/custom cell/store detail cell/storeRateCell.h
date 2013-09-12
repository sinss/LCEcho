//
//  storeRateCell.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol storeRateDelegate <NSObject>

- (void)didPressWithURL:(NSURL*)url;

@end

@interface storeRateCell : UITableViewCell
{
    id<storeRateDelegate> id;
    UIButton *rate1Button;
    UIButton *rate2Button;
    UIButton *rate3Button;
}
@property (assign) id<storeRateDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton *rate1Button;
@property (nonatomic, retain) IBOutlet UIButton *rate2Button;
@property (nonatomic, retain) IBOutlet UIButton *rate3Button;

- (IBAction)rate1ButtonPress:(UIButton*)sender;
- (IBAction)rate2ButtonPress:(UIButton*)sender;
- (IBAction)rate3ButtonPress:(UIButton*)sender;
@end
