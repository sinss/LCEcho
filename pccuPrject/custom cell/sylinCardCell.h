//
//  sylinCardCell.h
//  SlyCool001Project
//
//  Created by sinss on 12/8/13.
//
//

#import <UIKit/UIKit.h>

@interface sylinCardCell : UITableViewCell
{
    UIImageView *cardImageView;
    UILabel *cardNoLabel;
    UILabel *cardExpireDateLabel;
    UILabel *expireLabel;
}
@property (nonatomic, retain) IBOutlet UIImageView *cardImageView;
@property (nonatomic, retain) IBOutlet UILabel *cardNoLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardExpireDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *expireLabel;

@end
