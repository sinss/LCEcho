//
//  MoreDetailTableViewController.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "MoreDetailTableViewController.h"
#import "MoreContentViewController.h"
#import "SBJSON.h"
#import "SlyCoolC.h"

@interface MoreDetailTableViewController ()

- (void)createBarButton;
- (void)closeItemPress;
- (void)loadMoreContent;
- (void)showMailWithDictionary:(NSDictionary*)dict;
@end

@implementation MoreDetailTableViewController
@synthesize currentMoreItem;

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
    /*
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tableView_bg]];
    [self.tableView setBackgroundView:bgView];
    [bgView release];
     */
    [self createBarButton];
    [self loadMoreContent];
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
    [currentMoreItem release], currentMoreItem = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultArray count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *teamCellIdentidier = @"teamCellIdentidier";
    static NSString *optionCellIdentifier = @"optionCellIdentifier";
    NSUInteger row = [indexPath row];
    if ([currentMoreItem.CType isEqualToString:@"2"])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teamCellIdentidier];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:teamCellIdentidier] autorelease];
        }
        if (row % 2 == 1)
        {
            UIView *cellView = [[UIView alloc] init];
            [cellView setBackgroundColor:oddCellBackgroundColor];
            [cell setBackgroundView:cellView];
            [cellView release];
        }
        NSDictionary *dict = [resultArray objectAtIndex:[indexPath row]];
        
        [cell.textLabel setText:[dict valueForKey:@"title"]];
        [cell.detailTextLabel setText:[dict valueForKey:@"name"]];
        
        return cell;
    }
    else if ([currentMoreItem.CType isEqualToString:@"3"])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:optionCellIdentifier];
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:optionCellIdentifier] autorelease];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        
        NSDictionary *dict = [resultArray objectAtIndex:[indexPath row]];

        [cell.textLabel setText:[dict valueForKey:@"comment"]];
        [cell.detailTextLabel setText:[dict valueForKey:@"message"]];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:teamCellIdentidier];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:teamCellIdentidier] autorelease];
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
    NSDictionary *dict = [resultArray objectAtIndex:[indexPath row]];
    if ([currentMoreItem.CType isEqualToString:@"3"])
    {
        NSString *type = [dict valueForKey:@"type"];
        if ([type isEqualToString:@"0"])
        {
            //開敵網頁
            MoreContentViewController *moreContentView = [[MoreContentViewController alloc] initWithNibName:@"MoreContentViewController" bundle:nil];
            [moreContentView setCurrentUrl:[NSURL URLWithString:[dict valueForKey:@"url"]]];
            [moreContentView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentModalViewController:moreContentView animated:YES];
        }
        else if ([type isEqualToString:@"1"])
        {
            //寄信
            [self showMailWithDictionary:dict];
        }
    }
    
}

- (void)createBarButton
{
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.rightBarButtonItem = closeItem;
}
- (void)closeItemPress
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)loadMoreContent
{
    NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *results = [json objectWithString:currentMoreItem.CContent error:&error];
    //NSLog(@"result:%@",results);
    if ([currentMoreItem.CType isEqualToString:@"2"])
    {
        NSArray *teams = [results valueForKey:@"team"];
        resultArray = [[NSArray alloc] initWithArray:teams];
    }
    else if ([currentMoreItem.CType isEqualToString:@"3"])
    {
        NSArray *options = [results valueForKey:@"option"];
        resultArray  = [[NSArray alloc] initWithArray:options];
    }
}

#pragma mark - send mail delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *message;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"Result: cancel send";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: Mail Saved";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: Mail Send Faild";
            break;
        case MFMailComposeResultSent:
            message = @"Result: Mail send";
            break;
        default:
            message = @"Result : Mail no Send";
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - user define function
- (void)showMailWithDictionary:(NSDictionary*)dict;
{
    //iOS 3.0就支援了
    NSString *mail = [dict valueForKey:@"mail"];
    NSString *subject = [dict valueForKey:@"title"];
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    compose.mailComposeDelegate = self;
    [compose setSubject:subject];
    
    NSArray *toRecipients = [NSArray arrayWithObjects:mail,nil];
    [compose setToRecipients:toRecipients];
    //附加檔案
    
    NSString *emailBody = @"Dear 士林夢工廠";
    
    [compose setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:compose animated:YES];
    UIImage *image = [UIImage imageNamed:@""];
    [[[[compose navigationBar] items] objectAtIndex:0] setTitleView:[[UIImageView alloc] initWithImage:image]];
}

@end
