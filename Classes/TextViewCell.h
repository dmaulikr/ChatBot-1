#import <UIKit/UIKit.h>

@interface TextViewCell : UITableViewCell {
	UILabel *textView;
}

@property(nonatomic,retain) UILabel *textView;

+ (TextViewCell*)cellForTableView:(UITableView*)tableView;

@end
