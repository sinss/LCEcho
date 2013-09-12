//
//  customPictureCell.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import <UIKit/UIKit.h>

@class customImgaeView;

@interface customPictureCell : UITableViewCell
{
    customImgaeView *topicImageView;
}

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName;

@end
