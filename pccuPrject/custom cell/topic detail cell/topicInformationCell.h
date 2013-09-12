//
//  topicInformationCell.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>

@interface topicInformationCell : UITableViewCell
{
    UILabel *titleLabel;
    UITextView *contentTextView;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UITextView *contentTextView;


@end
