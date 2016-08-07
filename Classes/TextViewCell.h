#import <UIKit/UIKit.h>

@interface TextViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *textView;

+ (TextViewCell *)cellForTableView:(UITableView *)tableView;

@end
