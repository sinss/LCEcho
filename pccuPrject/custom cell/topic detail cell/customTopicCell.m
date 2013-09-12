//
//  customTopicCell.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "customTopicCell.h"
#import "customImgaeView.h"

#define customQuestionImageFrame CGRectMake(0, 0, 70, 70)

@implementation customTopicCell
@synthesize titleLabel, subTitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
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
    [titleLabel release], titleLabel = nil;
    [subTitleLabel release], subTitleLabel = nil;
    [topicImageView release], topicImageView = nil;
    [super dealloc];
}

- (void)initImageViewWithUrl:(NSURL*)url andImageName:(NSString*)imageName
{
    CGRect frame = customQuestionImageFrame;
    topicImageView = [[customImgaeView alloc] initWithFrame:frame andImageName:imageName andSmallInd:NO];
    [topicImageView downloadAndDisplayImageWithURL:url];
    [self addSubview:topicImageView];
}

@end
