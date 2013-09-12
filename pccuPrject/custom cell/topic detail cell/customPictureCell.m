//
//  customPictureCell.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "customPictureCell.h"
#import "customImgaeView.h"

#define customTopicImageView CGRectMake(8, 6, 300, 180)

@implementation customPictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [topicImageView release], topicImageView = nil;
    [super dealloc];
}

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName
{
    CGRect frame = customTopicImageView;
    topicImageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [topicImageView downloadAndDisplayImageWithURL:url];
    [self addSubview:topicImageView];
}

@end
