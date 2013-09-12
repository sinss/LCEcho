//
//  typeSel.h
//  SlyCool001
//
//  Created by EricHsiao on 2011/8/17.
//  Copyright 2011年 EricHsiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface typeSel : NSObject {
    NSString    *Category;
    NSString    *TypeName;
    NSString    *pStr;
    BOOL        isSelected;
}

@property (nonatomic, retain) NSString *Category;
@property (nonatomic, retain) NSString *TypeName;
@property (nonatomic, retain) NSString *pStr;
@property (nonatomic, assign) BOOL      isSelected;

@end
