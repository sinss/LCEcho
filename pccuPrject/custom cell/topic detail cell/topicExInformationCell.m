//
//  topicExInformationCell.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import "topicExInformationCell.h"

@implementation topicExInformationCell
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
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
    [super dealloc];
}
@end
