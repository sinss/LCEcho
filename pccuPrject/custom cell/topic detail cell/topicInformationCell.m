//
//  topicInformationCell.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/12.
//
//

#import "topicInformationCell.h"

@implementation topicInformationCell
@synthesize titleLabel, contentTextView;

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
    [titleLabel release], titleLabel = nil;
    [contentTextView release], contentTextView = nil;
    [super dealloc];
}
@end
