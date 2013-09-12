//
//  storeBonusCell.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "storeBonusCell.h"

@implementation storeBonusCell
@synthesize bonusContentTextView, cardImageView;

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
    [bonusContentTextView release], bonusContentTextView = nil;
    [cardImageView release], cardImageView = nil;
    [super dealloc];
}

@end
