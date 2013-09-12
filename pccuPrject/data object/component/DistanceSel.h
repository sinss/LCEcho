//
//  DistanceSel.h
//  SlyCool001Project
//
//  Created by Wan Jung Liu on 12/2/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistanceSel : NSObject{
NSString    *TypeName;
NSString    *pStr;
BOOL        isSelected;
}


@property (nonatomic, retain) NSString *TypeName;
@property (nonatomic, retain) NSString *pStr;
@property (nonatomic, assign) BOOL      isSelected;
@end
