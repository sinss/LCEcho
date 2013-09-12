//
//  MoreDetailTableViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class slyCoolC;
@interface MoreDetailTableViewController : UITableViewController
<MFMailComposeViewControllerDelegate>
{
    slyCoolC *currentMoreItem;
    NSArray *resultArray;
}
@property (nonatomic, retain) slyCoolC *currentMoreItem;

@end
