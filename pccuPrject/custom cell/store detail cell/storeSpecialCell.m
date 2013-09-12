//
//  storeSpecialCell.m
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import "storeSpecialCell.h"

@implementation storeSpecialCell
@synthesize cardServiceLabel, movieServiceLabel, jobLabel, othersLabel;

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
    [cardServiceLabel release], cardServiceLabel = nil;
    [movieServiceLabel release], movieServiceLabel = nil;
    [jobLabel release], jobLabel = nil;
    [othersLabel release], othersLabel = nil;
    [super dealloc];
}

@end
