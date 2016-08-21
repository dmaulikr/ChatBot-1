//
//  CBTBuddyTableViewCell.h
//  TestTask
//
//  Created by William Boles on 14/08/2016.
//
//

#import <UIKit/UIKit.h>

@interface CBTBuddyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMessageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end
