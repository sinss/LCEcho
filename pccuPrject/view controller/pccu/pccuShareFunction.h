//
//  pccuShareFunction.h
//  pccuPrject
//
//  Created by sinss on 12/10/28.
//  Copyright (c) 2012年 pccu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pccuShareFunction : NSObject

+(pccuShareFunction*)pccuShareFunctionInstance;

- (NSString*)GetPccuMenuNameWithMenuItem:(pccuMenuItem)item;

@end
