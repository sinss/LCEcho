//
//  MenuTVC.m
//  TVS
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SHMenuTVC.h"
#import <QuartzCore/QuartzCore.h>
#import "pccuShareFunction.h"


@implementation SHMenuTVC
@synthesize tableView;
-(id)initWithTitlesArray:(NSArray *)array andDelegate:(id<SHMenuDelegate>)del{
    
    self = [super init];
    
    if (self)
    {
        CGFloat height;
        if (IS_IPHONE_5)
        {
            height = 588;
        }
        else
        {
            height = 460;
        }
        delegate = del;
        titlesArray = [[NSArray alloc] initWithArray:array];
        groupArray = [[NSArray alloc] initWithObjects:@"文化學生會",@"文化媒體",@"更多", nil];
        self.view.frame = CGRectMake(0, 0, 199.5, height);
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat height;
    if (IS_IPHONE_5)
    {
        height = 588;
    }
    else
    {
        height = 460;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarshadow"]];
    [shadow setFrame:CGRectMake(155, 0, 43.5, height)];
    [self.view addSubview:shadow];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView *sbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarbg"]];
    [sbg setContentMode:UIViewContentModeScaleAspectFill];
    [sbg setFrame:CGRectMake(0, 0, 199.5, height)];
    [self.tableView setBackgroundView:sbg];
    self.view.backgroundColor = [UIColor clearColor];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    delegate = nil;
    [groupArray release], groupArray = nil;
    [titlesArray release]; titlesArray = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return 7;
    }
    else if (section == 1)
    {
        return 6;
    }
    else if (section == 2)
    {
        return 4;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //UIImageView *imageview = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerView_bgx.png"]] autorelease];
    //[imageview setFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    UIImageView *bg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]] autorelease];
    [bg setFrame:CGRectMake(0, 0, 199.5, 42.5)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                              self.view.frame.size.width - 10,
                                                               20)];
    [label setBackgroundColor:[UIColor clearColor]];
    //[label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:[groupArray objectAtIndex:section]];
    [bg addSubview:label];
    return bg;
}

- (UITableViewCell *)tableView:(UITableView *)tbl cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tbl dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    NSUInteger sec = [indexPath section];
    NSUInteger index = 0;
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (sec == 0)
    {
        index = row;
    }
    else if (sec == 1)
    {
        index = 7 + row;
    }
    else if (sec == 2)
    {
        index = 13 + row;
    }
    cell.textLabel.text = [[pccuShareFunction pccuShareFunctionInstance] GetPccuMenuNameWithMenuItem:index];
    if (os_version >= 7.0)
    {
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
    [bg setFrame:CGRectMake(0, 0, 199.5, 42.5)];
    // Configure the cell...
    cell.backgroundView = bg;
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"s%02i.png",(index + 1)]]];
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    NSUInteger index = 0;
    if (sec == 0)
    {
        index = row;
    }
    else if (sec == 1)
    {
        index = 7 + row;
    }
    else if (sec == 2)
    {
        index = 13 + row;
    }
    if ([delegate respondsToSelector:@selector(didSelectElementAtIndex:)])
    {    
        [delegate didSelectElementAtIndex:index];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
