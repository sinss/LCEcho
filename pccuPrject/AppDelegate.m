//
//  AppDelegate.m
//  pccuPrject
//
//  Created by sinss on 12/10/17.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "SHSidebarController.h"

#import "moreTableViewController.h"
#import "ActivityCategoryViewController.h"
#import "stageTableViewController.h"
#import "drawTableViewController.h"
#import "movieTableViewController.h"

#import "pccuNewsTableViewController.h"
#import "MoreContentViewController.h"
#import "appealViewController.h"
#import "pccuMoreViewController.h"
#import "pccuMedia1TableViewController.h"
#import "pccuMedia2TableViewController.h"

#import <Parse/Parse.h>

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    currentAddress = [[NSMutableString alloc] initWithCapacity:0];
    currentLocation = [[CLLocation alloc] init];
    //[RevMobAds startSessionWithAppID:@"502af58f2a7c4c0800000001"];
    self.window.backgroundColor = [UIColor whiteColor];
    //navigationbar
    if (os_version >= 7.0)
    {
        [[UINavigationBar appearance] setTintColor:navigationBarColor];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor darkGrayColor],
          UITextAttributeTextColor,
          [UIColor clearColor],
          UITextAttributeTextShadowColor,
          [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
          UITextAttributeTextShadowOffset,
          [UIFont fontWithName:@"Helvetica-Bold" size:15.0],
          UITextAttributeFont,
          nil]];
    }
    else
    {
        [[UINavigationBar appearance] setTintColor:navigationBarColor];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIColor whiteColor],
          UITextAttributeTextColor,
          [UIColor clearColor],
          UITextAttributeTextShadowColor,
          [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
          UITextAttributeTextShadowOffset,
          [UIFont fontWithName:@"Helvetica-Bold" size:15.0],
          UITextAttributeFont,
          nil]];
    }
    
    //toolbar
    [[UIToolbar appearance] setTintColor:navigationBarColor];
    launchView = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
    [self.window addSubview:launchView.view];
    [self.window makeKeyAndVisible];
    
    /*Parse Framework*/
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    [Parse setApplicationId:@"wG3NtpPfSnsqoReff8BTNxR508vgcb3zHhoOxGfJ" clientKey:@"70LSquTYgdyJZW1tFcatwcvKv4o7pBFPxgEZWWi8"];
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // [PFFacebookUtils initializeFacebook];
    // ****************************************************************************
    
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if (error.code == 3010)
    {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    }
    else
    {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self GetLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void) targetMethod
{
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(tabBarMethod:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)tabBarMethod:(NSTimer*) thetimer
{
    /*
     FlowCoverViewController *rootView = nil;
     
     NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TestFC" owner:self options:nil];
     rootView = [array objectAtIndex:0];
     
     self.window.rootViewController = rootView;
     [self.window makeKeyAndVisible];
     [launchView.view removeFromSuperview];
     [launchView release];
     */
    //不啟動flow cover主畫面
    //StoreListTableViewController *storeList = [[StoreListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:0];
        
    pccuNewsTableViewController *pccuNewsView1 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuNewsTableViewController *pccuNewsView2 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];    //申訴回應
    pccuNewsTableViewController *pccuNewsView3 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuNewsTableViewController *pccuNewsView4 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuNewsTableViewController *pccuNewsView5 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuNewsTableViewController *pccuNewsView6 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMedia1TableViewController *mediaTableView1 = [[pccuMedia1TableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMedia1TableViewController *mediaTableView2 = [[pccuMedia1TableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMedia2TableViewController *mediaTableView3 = [[pccuMedia2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMedia2TableViewController *mediaTableView4 = [[pccuMedia2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuNewsTableViewController *mediaTableView5 = [[pccuNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMedia2TableViewController *mediaTableView6 = [[pccuMedia2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    appealViewController *appealView = [[appealViewController alloc] initWithNibName:@"appealViewController" bundle:nil];
    moreTableViewController *moreView = [[moreTableViewController alloc] initWithStyle:UITableViewStylePlain];
    pccuMoreViewController *pccuMoreVioew = [[pccuMoreViewController alloc] initWithNibName:@"pccuMoreViewController" bundle:nil];
    appealViewController *weatherView = [[appealViewController alloc] initWithNibName:@"appealViewController" bundle:nil];
    [weatherView setType:1];
    pccuMedia2TableViewController *pccuActionView = [[pccuMedia2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [pccuNewsView1 setTypeOfPccuNews:pccuNewsType1];
    [pccuNewsView2 setTypeOfPccuNews:pccuNewsType2];
    [pccuNewsView3 setTypeOfPccuNews:pccuNewsType3];
    [pccuNewsView4 setTypeOfPccuNews:pccuNewsType4];
    [pccuNewsView5 setTypeOfPccuNews:pccuNewsType5];
    [pccuNewsView6 setTypeOfPccuNews:pccuNewsType6];
    
    [mediaTableView1 setPccuMediaType:2];
    [mediaTableView2 setPccuMediaType:3];
    [mediaTableView3 setPccuMediaType:1];
    [mediaTableView4 setPccuMediaType:5];    //文化Focus
    [mediaTableView5 setTypeOfPccuNews:pccuNewsType8];  //藝文快報
    [mediaTableView6 setPccuMediaType:4];  //其它出版
    [pccuActionView setPccuMediaType:6];
    
    [pccuNewsView1 setTitle:@"最新消息"];
    [pccuNewsView3 setTitle:@"部門動態"];
    [pccuNewsView4 setTitle:@"財務報表"];
    [pccuNewsView5 setTitle:@"活動預告"];
    [pccuNewsView6 setTitle:@"社團活動"];
    [pccuNewsView2 setTitle:@"申訴回應"];
    [appealView setTitle:@"申訴管道"];
    
    [mediaTableView1 setTitle:@"華岡廣播電台"];
    [mediaTableView2 setTitle:@"華岡電視台"];
    [mediaTableView3 setTitle:@"文化一周"];
    [mediaTableView4 setTitle:@"文化Focus"];
    [mediaTableView5 setTitle:@"藝文快報"];
    [mediaTableView6 setTitle:@"珍妮梁/喂,wei"];
    
    [weatherView setTitle:@"華岡氣象"];
    [pccuActionView setTitle:@"華岡生活動態"];
    [moreView setTitle:@"系聯卡"];
    [pccuMoreVioew setTitle:@"製作團隊"];
    
    NSURL *url = [NSURL URLWithString:[[appConfigRecord appConfigInstance] tabURL2]];
    [appealView setCurrentUrl:url];
    NSURL *url2 = [NSURL URLWithString:[[appConfigRecord appConfigInstance] ymsWeather]];
    [weatherView setCurrentUrl:url2];
    
    //新聞
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView1];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView4];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView5];
    UINavigationController *nav6 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView6];
    //申訴回應 (101/12/28調整)
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:pccuNewsView2];
    UINavigationController *nav7 = [[UINavigationController alloc] initWithRootViewController:appealView];
    //媒體
    UINavigationController *nav8 = [[UINavigationController alloc] initWithRootViewController:mediaTableView1];
    UINavigationController *nav9 = [[UINavigationController alloc] initWithRootViewController:mediaTableView2];
    UINavigationController *nav10 = [[UINavigationController alloc] initWithRootViewController:mediaTableView3];
    UINavigationController *nav11 = [[UINavigationController alloc] initWithRootViewController:mediaTableView4];
    UINavigationController *nav12 = [[UINavigationController alloc] initWithRootViewController:mediaTableView5];
    UINavigationController *nav13 = [[UINavigationController alloc] initWithRootViewController:mediaTableView6];
    //其它
    UINavigationController *nav14 = [[UINavigationController alloc] initWithRootViewController:weatherView];
    UINavigationController *nav15 = [[UINavigationController alloc] initWithRootViewController:pccuActionView];
    UINavigationController *nav16 = [[UINavigationController alloc] initWithRootViewController:moreView];
    UINavigationController *nav17  = [[UINavigationController alloc] initWithRootViewController:pccuMoreVioew];
    
    /*
    UITabBarController *tabControl = [[UITabBarController alloc] init];
    
    tabControl.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    tabControl.selectedIndex = 0;
    */
    /*
    activityView.title = [[appConfigRecord appConfigInstance] tabTitle1];
    stageView.title = [[appConfigRecord appConfigInstance] tabTitle2];
    drawView.title = [[appConfigRecord appConfigInstance] tabTitle3];
    movieView.title = [[appConfigRecord appConfigInstance] tabTitle4];
    //brandView.title = [[appConfigRecord appConfigInstance] tabTitle5];
    moreView.title = [[appConfigRecord appConfigInstance] tabTitle5];
     */
    
    NSDictionary *view1 = [NSDictionary dictionaryWithObjectsAndKeys:nav1, @"vc", @"0", @"title", nil];
    NSDictionary *view2 = [NSDictionary dictionaryWithObjectsAndKeys:nav3, @"vc", @"1", @"title", nil];
    NSDictionary *view3 = [NSDictionary dictionaryWithObjectsAndKeys:nav4, @"vc", @"2", @"title", nil];
    NSDictionary *view4 = [NSDictionary dictionaryWithObjectsAndKeys:nav5, @"vc", @"3", @"title", nil];
    NSDictionary *view5 = [NSDictionary dictionaryWithObjectsAndKeys:nav6, @"vc", @"4", @"title", nil];
    NSDictionary *view6 = [NSDictionary dictionaryWithObjectsAndKeys:nav2, @"vc", @"5", @"title", nil];
    NSDictionary *view7 = [NSDictionary dictionaryWithObjectsAndKeys:nav7, @"vc", @"6", @"title", nil];
    //媒體
    NSDictionary *view8 = [NSDictionary dictionaryWithObjectsAndKeys:nav8, @"vc", @"7", @"title", nil];
    NSDictionary *view9 = [NSDictionary dictionaryWithObjectsAndKeys:nav9, @"vc", @"8", @"title", nil];
    NSDictionary *view10 = [NSDictionary dictionaryWithObjectsAndKeys:nav10, @"vc", @"9", @"title", nil];
    NSDictionary *view11 = [NSDictionary dictionaryWithObjectsAndKeys:nav11, @"vc", @"10", @"title", nil];
    NSDictionary *view12 = [NSDictionary dictionaryWithObjectsAndKeys:nav12, @"vc", @"11", @"title", nil];
    NSDictionary *view13 = [NSDictionary dictionaryWithObjectsAndKeys:nav13, @"vc", @"12", @"title", nil];
    //其它
    NSDictionary *view14 = [NSDictionary dictionaryWithObjectsAndKeys:nav14, @"vc", @"13", @"title", nil];
    NSDictionary *view15 = [NSDictionary dictionaryWithObjectsAndKeys:nav15, @"vc", @"14", @"title", nil];
    NSDictionary *view16 = [NSDictionary dictionaryWithObjectsAndKeys:nav16, @"vc", @"15", @"title", nil];
    NSDictionary *view17 = [NSDictionary dictionaryWithObjectsAndKeys:nav17, @"vc", @"16", @"title", nil];
    
    [vcs addObject:view1];
    [vcs addObject:view2];
    [vcs addObject:view3];
    [vcs addObject:view4];
    [vcs addObject:view5];
    [vcs addObject:view6];
    [vcs addObject:view7];
    [vcs addObject:view8];
    [vcs addObject:view9];
    [vcs addObject:view10];
    [vcs addObject:view11];
    [vcs addObject:view12];
    [vcs addObject:view13];
    [vcs addObject:view14];
    [vcs addObject:view15];
    [vcs addObject:view16];
    [vcs addObject:view17];
    
    SHSidebarController *sidebar = [[SHSidebarController alloc] initWithArrayOfVC:vcs];
    //[tabControl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    self.window.rootViewController = sidebar;

    [self.window makeKeyAndVisible];
    
    [launchView.view removeFromSuperview];
    [launchView release];
    
    [pccuNewsView1 release];
    [pccuNewsView2 release];
    [pccuNewsView3 release];
    [pccuNewsView4 release];
    [pccuNewsView5 release];
    [pccuNewsView6 release];
    [mediaTableView1 release];
    [mediaTableView2 release];
    [mediaTableView3 release];
    [mediaTableView4 release];
    [mediaTableView5 release];
    [mediaTableView6 release];
    [appealView release];
    [moreView release];
    [pccuMoreVioew release];
    [weatherView release];
    [pccuActionView release];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    [nav5 release];
    [nav6 release];
    [nav7 release];
    [nav8 release];
    [nav9 release];
    [nav10 release];
    [nav11 release];
    [nav12 release];
    [nav13 release];
    [nav14 release];
    [nav15 release];
    [nav16 release];
    [nav17 release];
}


#pragma mark 取得位址
- (void)GetLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1.0f;
    [locationManager startUpdatingLocation];
    locationManager.headingFilter = kCLHeadingFilterNone;
    [locationManager startUpdatingHeading];
    
    if ((int)locationManager.location.coordinate.latitude > 0)
    {
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]||
            [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])
        {
            currentLocation =[[CLLocation alloc] initWithLatitude:25.085f longitude:121.524f];
        }
        else
        {
            currentLocation = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude] ;
        }
    }
    else
    {
        currentLocation =[[CLLocation alloc] initWithLatitude:25.085f longitude:121.524f];
    }
    
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=false",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]];
    NSData *locationData = [[[NSData alloc] initWithContentsOfURL:urlString] autorelease] ;
    NSString *responseString = [[[NSString alloc] initWithData:locationData  encoding:NSUTF8StringEncoding] autorelease];
    
    NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *results = [json objectWithString:responseString error:&error];
    
    //如果GPS有查到相對位置
	if (results)
    {
        if ([[results valueForKey:@"status"] isEqualToString:@"OK"])
        {
            NSString *addrA = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"] stringByReplacingOccurrencesOfString:@"台灣" withString:@""]  substringFromIndex:3]  ;
            
            NSString *lat = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"geometry"]  valueForKey:@"location"] valueForKey:@"lat"];
            
            NSString *lng = [[[[[results valueForKey:@"results"] objectAtIndex:0] valueForKey:@"geometry"]  valueForKey:@"location"] valueForKey:@"lng"];
            //            NSString *addrC = (addrB) ? [NSString stringWithFormat:@"%@號",addrB]:addrB;
            //            [CurrAddr setString:@"%@",addrA];
            
            //            addrA = @"台北市士林區承德路四段186號";
            [currentAddress setString:@""];
            [currentAddress appendFormat:@"%@ 附近",addrA];
            currLat = [lat doubleValue];
            currLng = [lng doubleValue];
            //            NSLog(@"%@",responseString);
            
            NSLog(@"lat=%f lng=%f Address=%@",currLat, currLng, currentAddress);
            //            NSLog(@"lat=%f lng=%f",currLat, currLng);
            currentLocation = [[CLLocation alloc] initWithLatitude:currLat longitude:currLng];
            /*
             儲存位置
             */
            [[appConfigRecord appConfigInstance] setCurrentLocation:currentLocation];
            [[appConfigRecord appConfigInstance] setCurrentAddress:currentAddress];
        }
	}
}

#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error
{
    if ([result boolValue])
    {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}

@end
