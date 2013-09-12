//
//  slyCoolC.h
//  SlyCool001Project
//
//  Created by Wan Jung Liu on 11/12/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface slyCoolC : NSObject {
    NSString * CName;
    NSString * CContent;
    NSString * CType;
    NSString * Mail;
}

@property (nonatomic, retain) NSString * CName;
@property (nonatomic, retain) NSString * CContent;
@property (nonatomic, retain) NSString * CType;
@property (nonatomic, retain) NSString * Mail;

@end