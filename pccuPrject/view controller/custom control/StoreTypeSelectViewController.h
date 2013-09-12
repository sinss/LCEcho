//
//  StoreTypeSelectViewController.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    StoreCategoryType = 0,
    StoreCategoryDistance = 1,
};

@class StoreTypeSelectViewController;
@protocol StoreTypeSelectDelegate <NSObject>

- (void)storeTypeView:(StoreTypeSelectViewController*)view didSelectWithPredict:(NSString*)predictate;

@end

@interface StoreTypeSelectViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate>
{
    id <StoreTypeSelectDelegate> delegate;
    IBOutlet UIPickerView *typePicker;
    NSArray *typeArray;
    NSArray *distanceArray;
}
@property (assign) id<StoreTypeSelectDelegate> delegate;

- (IBAction)doneButtonPress:(id)sender;
- (IBAction)backButtonPress:(id)sender;

@end
