#import <UIKit/UIKit.h>

@interface CBTTextViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *textView;

+ (CBTTextViewCell *)cellForTableView:(UITableView *)tableView;

@end
