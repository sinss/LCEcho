//
//  topicDetailViewController.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>

@class slyCoolA;
@interface topicDetailViewController : UITableViewController
{
    slyCoolA *currentTopic;
    NSArray *groupArray;
    NSArray *resultArray;
}
@property (nonatomic, retain) slyCoolA *currentTopic;

@end
