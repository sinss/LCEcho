//
//  slMapViewController.m
//  SlyCool001
//
//  Created by EricHsiao on 2011/7/10.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import "slMapViewController.h"
#import "globalFunction.h"
#import "StoreDetailTableViewController.h"
#import "appConfigRecord.h"

@interface slMapViewController()

@end

@implementation slMapViewController
@synthesize mapView,sylCool;
@synthesize currLocation, currAddress;
@synthesize storeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)dealloc
{
    [sylCool release];
    [annsArray release];
    [mapView release];
    [storeArray release], storeArray = nil;
    [currAddress release], currAddress = nil;
    [currLocation release], currLocation = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)resetMap2sylCool
{
    MKCoordinateSpan mapSpan;
    mapSpan.latitudeDelta = 0.02f;
    mapSpan.longitudeDelta = 0.02f;
    MKCoordinateRegion mapRegion;
    mapRegion.center = sylCool.coordinate;
    mapRegion.span = mapSpan;
    mapView.region = mapRegion;
    [mapView removeAnnotations:mapView.annotations];
}

- (MKAnnotationView *) mapView:(MKMapView *)eMapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    AddressAnnotation *addTheAnnotation = (AddressAnnotation *)annotation;
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[eMapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if(pinView == nil) {
        
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"] autorelease];
        pinView.frame = CGRectMake(0, 0, 25, 25);
        
    }
    else
    {
        pinView.annotation = annotation;
    }  
    
    switch (addTheAnnotation.mPinType)
    {
        case 0:
            pinView.pinColor = MKPinAnnotationColorGreen;
            break;
        case 1:
            pinView.pinColor = MKPinAnnotationColorRed;
            break;
        case 2:
            pinView.pinColor = MKPinAnnotationColorPurple;
            break;
        case 3:
            pinView.image =[UIImage imageNamed:@"i_am_here.png"];
            break;    
    }
	
	pinView.animatesDrop=TRUE;
	pinView.canShowCallout = YES;
	pinView.calloutOffset = CGPointMake(-5, 5);
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
    return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    AddressAnnotation *addTheAnnotation = (AddressAnnotation *)view.annotation;
    
    StoreDetailTableViewController *detailViewController = [[StoreDetailTableViewController alloc] initWithStyle:UITableViewStylePlain];
    NSInteger tag = addTheAnnotation.mTag;
    if (tag < 0)
        return;
    StoreTemp *store = [storeArray objectAtIndex:tag];
    [detailViewController setCurrentStore:store];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

- (void)showAllSlyCool
{
    
    if ([annsArray count] > 0)
    {
        [mapView removeAnnotations:annsArray];
        [annsArray removeAllObjects];
    }
    
    for(NSInteger i = 0 ; i <= storeArray.count ;i++)
    {
        NSString *mTitle = [[[NSString alloc] init] autorelease];
        NSString *mSubTitle = [[[NSString alloc] init] autorelease];
        NSString *slyCardSrv = [[[NSString alloc] init] autorelease];
        NSString *slyPush = [[[NSString alloc] init] autorelease];
        NSInteger mPinType= 0;
        CLLocationCoordinate2D location;
        if(i >0)
        {
            StoreTemp *s = [storeArray objectAtIndex:(i-1)];
            //StoreTemp *s = (StoreTemp *)[appDelegate.tbl002 objectAtIndex:(i-1)];
            location.latitude       = [s.MapX doubleValue];
            location.longitude      = [s.MapY doubleValue];
            
            mTitle                  = [mTitle stringByAppendingString:s.StoreName];
            mTitle                  = [mTitle stringByAppendingFormat:@" 距離%@",[globalFunction formatDistance:s.Distance]];
            mSubTitle               = [mSubTitle stringByAppendingString:s.StoreAddress];
            
            slyCardSrv              = [slyCardSrv stringByAppendingString:s.slyCardSrv];
            slyPush                 = [slyPush stringByAppendingString:s.slyPush];
            mPinType                = 0;
            
        }
        else
        {
            location.latitude       = currLocation.coordinate.latitude;
            location.longitude      = currLocation.coordinate.longitude;
            mTitle                  =  [mTitle stringByAppendingString:@"我在這"];
            NSLog(@"XXX  %@",currAddress);
            mSubTitle               = [mSubTitle stringByAppendingString:currAddress];
            slyCardSrv              = [slyCardSrv stringByAppendingString:@""];
            slyPush                 = [slyPush stringByAppendingString:@""];
            mPinType                    = 3;
            
        }
        addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
        addAnnotation.mTitle = mTitle;
        addAnnotation.mSubTitle =mSubTitle;
        addAnnotation.mTag = (i-1);
        addAnnotation.mPinType  = mPinType;
        if ([slyCardSrv isEqualToString:@"Y"]) {
            addAnnotation.mPinType = 0;
            addAnnotation.mTitle = [NSString stringWithFormat:@"%@<可辦卡>",mTitle];
        }
        if ([slyPush isEqualToString:@"Y"]) {
            addAnnotation.mPinType = 0;
            addAnnotation.mTitle = [NSString stringWithFormat:@"%@<特推>", mSubTitle];
        }
        
        [mapView addAnnotation:addAnnotation];
        [annsArray addObject:addAnnotation];
        [addAnnotation release];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetMap2sylCool];
    [self showAllSlyCool];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (annsArray == nil)
    {
        annsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if (currAddress == nil)
    {
        currAddress = [[NSString alloc] initWithString:@"偵測不到位置..."];
    }
    if (currLocation == nil)
    {
        currLocation = [[CLLocation alloc] init];
    }
    mapView.frame = CGRectMake(0,0,320,416);
    //NSString *locCenterX = [NSString stringWithFormat:@"25.085"];
    //NSString *locCenterY = [NSString stringWithFormat:@"121.524"];
    NSString *locCenterX = [[[appConfigRecord appConfigInstance] latitude] stringValue];
    NSString *locCenterY = [[[appConfigRecord appConfigInstance] longitude] stringValue];
    //新增如果只有一間店家，則以店家為中心
    if ([storeArray count] == 1)
    {
        StoreTemp *store = [storeArray objectAtIndex:0];
        sylCool = [[CLLocation alloc] initWithLatitude:[store.MapX doubleValue] longitude:[store.MapY doubleValue]];
    }
    else
    {
        if ([locCenterX integerValue] == 0 || [locCenterY integerValue]== 0)
        {
            sylCool = [[CLLocation alloc] initWithLatitude:[[appConfigRecord appConfigInstance] currentLocation].coordinate.latitude longitude:[[appConfigRecord appConfigInstance] currentLocation].coordinate.longitude];
        }
        else
        {
            sylCool = [[CLLocation alloc] initWithLatitude:[locCenterX doubleValue] longitude:[locCenterY doubleValue]];
        }
    }
    
    //[self resetMap2sylCool];
    //[self showAllSlyCool];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
