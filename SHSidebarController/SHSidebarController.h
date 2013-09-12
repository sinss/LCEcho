//
//  SHSidebarController.h
//  Showy
//
//  Created by Jorge Izquierdo on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMenuTVC.h"



@interface SHSidebarController : UIViewController <SHMenuDelegate>
{
    BOOL menuOpened;
    UITapGestureRecognizer *tap;
    UISwipeGestureRecognizer *swipeL, *swipeR;
    UIView *behindV;
    
    NSInteger current;
}
@property (nonatomic, retain) UIViewController *mainVC, *menuVC;
@property (nonatomic, retain) NSArray *viewsArray;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain)  UISwipeGestureRecognizer *swipeR;

-(id)initWithArrayOfVC:(NSArray *)array;

-(void)menuChange;
-(void)closeAndChange:(UIViewController *)vc;
-(void)changeMain:(UIViewController *)main;
-(void)goToView:(NSInteger)index;
-(void)closeAndPop;
@end
