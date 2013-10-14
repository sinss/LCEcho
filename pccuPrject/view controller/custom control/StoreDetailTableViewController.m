//
//  StoreDetailTableViewController.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "StoreDetailTableViewController.h"
#import "MoreContentViewController.h"
#import "appConfigRecord.h"
#import "globalFunction.h"
#import "StoreTemp.h"
#import "storeInformationCell.h"
#import "storeBonusCell.h"
#import "storeSpecialCell.h"
#import "slMapViewController.h"
#import "shareHeaderView.h"

@interface StoreDetailTableViewController ()

- (void)createStoreInformation;

- (NSString*)cellTitleWithString:(NSString*)desc;
- (void)crateBarButton;
- (void)showMapView;

@end

@implementation StoreDetailTableViewController
@synthesize currentStore;
@synthesize currLocation, currAddress;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tableView_bg]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
    [self crateBarButton];
    [self createStoreInformation];
    if (facebook == nil)
    {
        facebook = [[Facebook alloc] initWithAppId:facebookAppID andDelegate:self];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [currentStore release], currentStore = nil;
    [detailArray release], detailArray = nil;
    [groupArray release], groupArray = nil;
    [currAddress release], currAddress = nil;
    [currLocation release], currLocation = nil;
    [mapView release], mapView = nil;
    [facebook release], facebook = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [groupArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *title = [groupArray objectAtIndex:section];
    if ([title isEqualToString:@"information"])
    {
        return 1;
    }
    else if ([title isEqualToString:@"bonus"])
    {
        return 1;
    }
    else if ([title isEqualToString:@"rate"])
    {
        return 1;
    }
    else if ([title isEqualToString:@"special"])
    {
        return 1;
    }
    else
    {
        return 0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [groupArray objectAtIndex:[indexPath section]];
    if ([title isEqualToString:@"information"])
    {
        return 240;
    }
    else if ([title isEqualToString:@"bonus"])
    {
        return 170;
    }
    else if ([title isEqualToString:@"rate"])
    {
        return 100;
    }
    else if ([title isEqualToString:@"special"])
    {
        return 110;
    }
    else
    {
        return 0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    shareHeaderView *headerView = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"shareHeaderView" owner:self options:nil];
    for (id currentObj in topLevelObjects)
    {
        if ([currentObj isKindOfClass:[shareHeaderView class]])
        {
            headerView = currentObj;
            break;
        }
    }
    NSString *title = [groupArray objectAtIndex:section];
    [headerView.titleLabel setText:[self cellTitleWithString:title]];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    static NSString *CellIdentifier = @"Cell";
    static NSString *informationCellIdentifier = @"informationCellIdentifier";
    static NSString *bonusCellIdentifier = @"bonusCellIdentifier";
    static NSString *rateCellIdentifier = @"rateCellIdentifier";
    static NSString *specialCellIdentifier = @"specialCellIdentifier";
    NSString *title = [groupArray objectAtIndex:sec];
    if ([title isEqualToString:@"information"])
    {
        storeInformationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:informationCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeInformationCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[storeInformationCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.titleLabel setText:currentStore.StoreName];
        NSURL *url =[NSURL URLWithString:currentStore.PicA];
        [cell initImageViewWithUrl:url andImageName:currentStore.StoreName];
        [cell.addressLabel setText:currentStore.StoreAddress];
        [cell.phoneTextView setText:currentStore.StoreTel];
        [cell.distanceLabel setText:[NSString stringWithFormat:@"距離%@",[globalFunction formatDistance:currentStore.Distance]]];
        
        return cell;
    }
    else if ([title isEqualToString:@"bonus"])
    {
        storeBonusCell *cell = [self.tableView dequeueReusableCellWithIdentifier:bonusCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeBonusCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[storeBonusCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.bonusContentTextView setText:[NSString stringWithFormat:@"%@\n%@",currentStore.StoreNewsDate,currentStore.StoreNews]];
        return cell;
    }
    else if ([title isEqualToString:@"rate"])
    {
        storeRateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:rateCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeRateCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[storeRateCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setDelegate:self];
        }
        [cell.rate1Button setTitle:@"N/A" forState:UIControlStateNormal];
        [cell.rate2Button setTitle:@"N/A" forState:UIControlStateNormal];
        [cell.rate3Button setTitle:@"N/A" forState:UIControlStateNormal];
        if ([currentStore.StoreP1URL length] > 0)
        {
            [cell.rate1Button setTitle:currentStore.StoreP1URL forState:UIControlStateNormal];
        }
        if ([currentStore.StoreP2URL length] > 0)
        {
            [cell.rate2Button setTitle:currentStore.StoreP2URL forState:UIControlStateNormal];
        }
        if ([currentStore.StoreP3URL length] > 0)
        {
            [cell.rate3Button setTitle:currentStore.StoreP3URL forState:UIControlStateNormal];
        }
        return cell;
    }
    else if ([title isEqualToString:@"special"])
    {
        storeSpecialCell *cell = [self.tableView dequeueReusableCellWithIdentifier:specialCellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"storeSpecialCell" owner:self options:nil];
            for (id currentObj in topLevelObjects)
            {
                if ([currentObj isKindOfClass:[storeSpecialCell class]])
                {
                    cell = currentObj;
                    break;
                }
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if ([currentStore.StoreHR isEqualToString:@"Y"])
        {
            [cell.jobLabel setHidden:YES];
        }
        if ([currentStore.slyCardSrv isEqualToString:@"Y"])
        {
            [cell.cardServiceLabel setHidden:YES];
        }
        if ([currentStore.MovTicket isEqualToString:@"Y"])
        {
            [cell.movieServiceLabel setHidden:YES];
        }
        if ([currentStore.StoreP4URL length] > 0)
        {
            [cell.othersLabel setText:currentStore.StoreP4];
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        return cell;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - storeRateDelegate
- (void)didPressWithURL:(NSURL *)url
{
    MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
    [moreContentView setCurrentUrl:url];
    [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:moreContentView animated:YES completion:nil];
    [moreContentView release];
}

#pragma mark - user define function

- (void)crateBarButton
{
    UIBarButtonItem *mapItem  = [[UIBarButtonItem alloc] initWithTitle:@"地圖" style:UIBarButtonItemStylePlain target:self action:@selector(showMapView)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0.0, 0.0, 30.0, 30.0);
    [button setImage:[UIImage  imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"facebook_icon1" ofType:@"png"]] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(FBshare:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fbItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:fbItem, mapItem, nil];
    [mapItem release];
    [fbItem release];
}

- (void)showMapView
{
    if(mapView == nil)
    {
        mapView = [[slMapViewController alloc] initWithNibName:@"slMapViewController" bundle:nil];
    }
    NSLog(@"%@",[[appConfigRecord appConfigInstance] currentLocation]);
    NSLog(@"%@",[[appConfigRecord appConfigInstance] currentAddress]);
    mapView.currLocation = [[appConfigRecord appConfigInstance] currentLocation];
    mapView.currAddress = [[appConfigRecord appConfigInstance] currentAddress];
    mapView.storeArray = [NSArray arrayWithObject:currentStore];
    
    //[mapView viewWillAppear:YES];
	mapView.title = @"士林大地圖";
    [self.navigationController pushViewController:mapView animated:YES];
}

#pragma mark 建立商店資料的格式
- (void)createStoreInformation
{
    /*
     1.建立標題資料
     2.建立所有資料表
     3.篩選不需要的資料表
     */
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger *rateCount = 0;
    NSInteger *specialCount = 0;
    /*
     基本資訊-->
     標題
     地址
     電話
     距離
     圖片
     */
    
    /*
     持卡優惠-->
     優惠項目
     適用卡別-->
     圖
     */
    
    /*
     風評-->
     食記
     大改造專區
     會員評比
     */
    if ([currentStore.StoreP1URL length] > 0)
    {
        rateCount ++;
    }
    if ([currentStore.StoreP2URL length] > 0)
    {
        rateCount ++;
    }
    if ([currentStore.StoreP3URL length] > 0)
    {
        rateCount ++;
    }
    /*
     打工快報
     該店為士林卡辦卡地點
     該店為美麗華團票取票點
     */
    if ([currentStore.StoreHR isEqualToString:@"Y"])
    {
        specialCount ++;
    }
    if ([currentStore.slyCardSrv isEqualToString:@"Y"])
    {
        specialCount ++;
    }
    if ([currentStore.MovTicket isEqualToString:@"Y"])
    {
        specialCount ++;
    }
    if ([currentStore.StoreP4URL length] > 0)
    {
        specialCount ++;
    }
    /*
     建立標題
     */
    [titleArray addObject:[NSString stringWithFormat:@"information"]];
    [titleArray addObject:[NSString stringWithFormat:@"bonus"]];
    if (rateCount > 0)
    {
        [titleArray addObject:[NSString stringWithFormat:@"rate"]];
    }
    if (specialCount > 0)
    {
        [titleArray addObject:[NSString stringWithFormat:@"special"]];
    }
    groupArray = [[NSArray alloc] initWithArray:titleArray];
}

- (NSString*)cellTitleWithString:(NSString*)desc
{
    NSString *result = nil;
    if ([desc isEqualToString:@"information"])
    {
        result = [NSString stringWithFormat:@"店鋪資訊"];
    }
    else if ([desc isEqualToString:@"bonus"])
    {
        result = [NSString stringWithFormat:@"持卡特約優惠"];
    }
    else if ([desc isEqualToString:@"rate"])
    {
        result = [NSString stringWithFormat:@"評價"];
    }
    else if ([desc isEqualToString:@"special"])
    {
        result = [NSString stringWithFormat:@"特別訊息"];
    }
    return result;
}

#pragma mark - facebook connect
- (IBAction) FBshare: (id) object
{
    NSMutableString *FBshareStr  = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBimgStr    = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBHeadStr   = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBLinkStr   = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBCaptionStr= [NSMutableString stringWithCapacity:0];
    /*
     create facebook information
     */
    NSString * fbFootStr = [[[NSString alloc] init]autorelease];
    fbFootStr = [fbFootStr stringByAppendingString:[[appConfigRecord appConfigInstance] fbFootString]];
    NSString * fbHeadPrefix = [[[NSString alloc] init]autorelease];
    fbHeadPrefix = [fbHeadPrefix stringByAppendingString:[[appConfigRecord appConfigInstance] fbHeader]];
    [FBCaptionStr setString:(fbFootStr.length == 0?@"":fbFootStr)] ;
    [FBHeadStr appendFormat:@"%@%@",(fbHeadPrefix == nil?@"":fbHeadPrefix),currentStore.StoreName];
    [FBLinkStr setString:(currentStore.FBURL.length == 0 ?@"http://www.slycool.com/":currentStore.FBURL)];

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FBLinkStr, @"link",
                                   FBimgStr, @"picture",
                                   FBHeadStr, @"name",
                                   FBCaptionStr, @"caption",
                                   FBshareStr, @"description",
                                   nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
    
}

- (void)dialogDidComplete:(FBDialog *)dialog
{
    NSLog(@"Here in Dialog did complete.bbb");
}

- (void)dialogCompleteWithUrl:(NSURL *)url
{
    
    //    NSLog(@"dialogCompleteWithUrl:%@",url);
    
    NSLog(@"Here in Dialog complete.bbb");
    
    if ([url.absoluteString rangeOfString:@"post_id="].location != NSNotFound)
    {
        UIAlertView *avx=[[[UIAlertView alloc] initWithTitle:@"分享至你的Facebook" message:@"己成功上傳至你的牆上." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [avx show];
        
    }
    else
    {
        NSLog(@"user pressed cancel");
    }
}

- (void)dialogDidNotCompleteWithUrl:(NSURL *)url
{
    
    NSLog(@"Here in Dialog did not complete with URL.bbb");
    
}

- (void)dialogDidNotComplete:(FBDialog *)dialog{
    
    NSLog(@"Here in Dialog did not complete.bbb");
    
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error
{
    NSLog(@"Here in Dialog did failed.bbb %@",error);
}

-(void) postFunc
{
    NSLog(@"FB post Func");
    NSMutableString *FBshareStr  = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBimgStr    = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBHeadStr   = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBLinkStr   = [NSMutableString stringWithCapacity:0];
    NSMutableString *FBCaptionStr= [NSMutableString stringWithCapacity:0];
    /*
     create facebook information
     */
    NSString * fbFootStr = [[[NSString alloc] init]autorelease];
    fbFootStr = [fbFootStr stringByAppendingString:[[appConfigRecord appConfigInstance] fbFootString]];
    NSString * fbHeadPrefix = [[[NSString alloc] init]autorelease];
    fbHeadPrefix = [fbHeadPrefix stringByAppendingString:[[appConfigRecord appConfigInstance] fbHeader]];
    [FBCaptionStr setString:(fbFootStr.length == 0?@"":fbFootStr)] ;
    [FBHeadStr appendFormat:@"%@%@",(fbHeadPrefix == nil?@"":fbHeadPrefix),currentStore.StoreName];
    [FBLinkStr setString:(currentStore.FBURL.length == 0 ?@"http://www.slycool.com/":currentStore.FBURL)] ;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FBLinkStr, @"link",
                                   FBimgStr, @"picture",
                                   FBHeadStr, @"name",
                                   FBCaptionStr, @"caption",
                                   FBshareStr, @"description",
                                   nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
    
}
- (void)fbDialogLogin:(NSString*)token expirationDate:(NSDate*)expirationDate
{
    NSLog(@"fbDialogLogin");
    [self postFunc];
    
    NSLog(@"did login.bbb");
}

- (void)fbDialogNotLogin:(BOOL)cancelled
{
    NSLog(@"fbDialogNotLogin");
    
    NSLog(@"did not login.bbb");
}
- (void) fbDidLogin
{
    
    NSLog(@"did login.bbb");
}

- (void) fbDidNotLogin:(BOOL)cancelled
{
    
    NSLog(@"did not login.bbb");
}


@end
