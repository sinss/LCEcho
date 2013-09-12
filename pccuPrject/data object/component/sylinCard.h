//
//  sylinCard.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import <Foundation/Foundation.h>

@interface sylinCard : NSObject
{
    NSString *cardNo;
    NSString *cardName;
    NSString *cardExpireDate;
    NSString *cardType;
}
@property (nonatomic, retain) NSString *cardNo;
@property (nonatomic, retain) NSString *cardName;
@property (nonatomic, retain) NSString *cardExpireDate;
@property (nonatomic, retain) NSString *cardType;

@end
