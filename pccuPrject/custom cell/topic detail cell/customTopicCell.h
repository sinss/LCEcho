//
//  customTopicCell.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>

@class customImgaeView;
@interface customTopicCell : UITableViewCell <UITextViewDelegate>
{
    customImgaeView *topicImageView;
    UILabel *titleLabel;
    UILabel *subTitleLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subTitleLabel;

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;

@end
