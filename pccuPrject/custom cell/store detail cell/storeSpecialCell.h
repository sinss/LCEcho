//
//  storeSpecialCell.h
//  SlyCoolForEst
//
//  Created by sinss on 12/7/31.
//  Copyright (c) 2012年 SlyCool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface storeSpecialCell : UITableViewCell
{
    UILabel *cardServiceLabel;
    UILabel *movieServiceLabel;
    UILabel *jobLabel;
    UILabel *othersLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *cardServiceLabel;
@property (nonatomic, retain) IBOutlet UILabel *movieServiceLabel;
@property (nonatomic, retain) IBOutlet UILabel *jobLabel;
@property (nonatomic, retain) IBOutlet UILabel *othersLabel;

@end
