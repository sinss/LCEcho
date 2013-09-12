//
//  sylinCardCell.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import "sylinCardCell.h"

@implementation sylinCardCell
@synthesize cardExpireDateLabel, cardImageView, cardNoLabel, expireLabel;

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
    [cardExpireDateLabel release], cardExpireDateLabel = nil;
    [cardImageView release], cardImageView = nil;
    [cardNoLabel release], cardNoLabel = nil;
    [expireLabel release], expireLabel = nil;
    [super dealloc];
}

@end
