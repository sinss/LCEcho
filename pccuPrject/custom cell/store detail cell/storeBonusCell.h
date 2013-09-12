//
//  storeBonusCell.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storeBonusCell : UITableViewCell
{
    UITextView *bonusContentTextView;
    UIImageView *cardImageView;
}
@property (nonatomic, retain) IBOutlet UITextView *bonusContentTextView;
@property (nonatomic, retain) IBOutlet UIImageView *cardImageView;

@end
