//
//  sylinCard.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import "sylinCard.h"

@implementation sylinCard
@synthesize cardExpireDate, cardName, cardNo, cardType;

- (void)dealloc
{
    [cardExpireDate release], cardExpireDate = nil;
    [cardNo release], cardNo = nil;
    [cardName release], cardName = nil;
    [cardType release], cardType = nil;
    [super dealloc];
}
@end
