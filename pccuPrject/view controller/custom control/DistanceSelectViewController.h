//
//  DistanceSelectViewController.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/30.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalFunction.h"

@class DistanceSelectViewController;
@protocol distancePicker <NSObject>

- (void)distanceView:(DistanceSelectViewController*)view didSelectDistanceWithPredict:(NSString*)predicateStr;

@end
@interface DistanceSelectViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    id<distancePicker> delegate;
    IBOutlet UIPickerView *distancePicker;
    NSArray *distanceArray;
    
}

@property (assign) id<distancePicker> delegate;

- (IBAction)doneButtonPress:(id)sender;
- (IBAction)backButtonPress:(id)sender;

@end
