//
//  slMapViewController.h
//  SlyCool001
//
//  Created by EricHsiao on 2011/7/10.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "StoreTemp.h"
#import "AddressAnnotation.h"

@interface slMapViewController : UIViewController {
    MKMapView *mapView;
    CLLocation *sylCool;
    NSMutableArray *annsArray;
    AddressAnnotation *addAnnotation;
    
    NSArray *storeArray;
    CLLocation *currLocation;
    NSString *currAddress;
}

- (void)resetMap2sylCool;
- (void)showAllSlyCool;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation *sylCool;
@property (nonatomic, retain) NSArray *storeArray;
@property (nonatomic, retain) CLLocation *currLocation;
@property (nonatomic, retain) NSString *currAddress;

@end
