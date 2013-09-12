//
//  storeInformationCell.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customImgaeView;
@interface storeInformationCell : UITableViewCell
{
    customImgaeView *storeImageView;
    UILabel *titleLabel;
    UILabel *addressLabel;
    UILabel *distanceLabel;
    UITextView *phoneTextView;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet customImgaeView *storeImageView;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (nonatomic, retain) IBOutlet UITextView *phoneTextView;


- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;
- (IBAction)phoneButtonPress:(UIButton*)sender;

@end
