//
//  sylinCreateCell.h
//  SlyCool001
//
//  Created by sinss on 12/8/14.
//  Copyright (c) 2012年 slycool001. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sylinCreateCell;
@protocol sylinCreateDelegate <NSObject>

- (void)didPressStartAuthorizeSylinCard;
- (void)didPressApplySylinButton;
- (void)didPressCreateSylinButton;

@end

@interface sylinCreateCell : UITableViewCell
{
    id<sylinCreateDelegate> delegate;
    UITextField *cardNoField;
    UITextField *cardNameField;
}
@property (assign) id<sylinCreateDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *cardNoField;
@property (nonatomic, retain) IBOutlet UITextField *cardNameField;

- (IBAction)authorizeButtonPress:(id)sender;
- (IBAction)applySylinCardButtonPress:(id)sender;
- (IBAction)createSylinCardButtonPress:(id)sender;

@end
