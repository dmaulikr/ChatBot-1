#import <UIKit/UIKit.h>

@interface TextViewCell : UITableViewCell {
	UILabel *textView;
}

@property(nonatomic,strong) UILabel *textView;

+ (TextViewCell*)cellForTableView:(UITableView*)tableView;

@end
