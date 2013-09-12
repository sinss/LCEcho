//
//  cardAuthorizeRecord.m
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import "cardAuthorizeRecord.h"

@implementation cardAuthorizeRecord
@synthesize cardStartDate, cardNo, cardName, cardEndDate, cardType;

- (void)dealloc
{
    [cardStartDate release], cardStartDate = nil;
    [cardNo release], cardNo = nil;
    [cardName release], cardName = nil;
    [cardEndDate release], cardEndDate = nil;
    [cardType release], cardType = nil;
    [super dealloc];
}

@end
