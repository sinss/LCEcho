//
//  AppConfiguration.h
//  SlyCool001Project
//
//  Created by Wan Jung Liu on 11/12/27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfiguration : NSObject{
    NSString * appConfig;
    NSString * appValue;
}

@property (nonatomic, retain) NSString * appConfig;
@property (nonatomic, retain) NSString * appValue;

@end
