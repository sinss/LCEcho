//
//  cardAuthorizeRecord.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import <Foundation/Foundation.h>

@interface cardAuthorizeRecord : NSObject
{
    NSString *cardStartDate;
    NSString *cardNo;
    NSString *cardName;
    NSString *cardEndDate;
    NSString *cardType;
}
@property (nonatomic, retain) NSString *cardStartDate;
@property (nonatomic, retain) NSString *cardNo;
@property (nonatomic, retain) NSString *cardName;
@property (nonatomic, retain) NSString *cardEndDate;
@property (nonatomic, retain) NSString *cardType;

@end
