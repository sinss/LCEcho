//
//  AppDelegate.h
//  pccuPrject
//
//  Created by sinss on 12/10/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowCoverViewController.h"
#import "LaunchViewController.h"
#import "ErrorViewController.h"
#import "FBConnect.h"


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSMutableString *currentAddress;
    double currLat;
    double currLng;
    
    LaunchViewController *launchView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

- (void)targetMethod;
- (void)GetLocation;

@end
