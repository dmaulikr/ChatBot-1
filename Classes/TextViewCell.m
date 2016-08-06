#import "TextViewCell.h"


@interface TextViewCell ()
@end


@implementation TextViewCell
@synthesize textView;

+ (UITableViewCell*)cellForTableView:(UITableView*)tableView {
	NSString *ident = NSStringFromClass([self class]);
	TextViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:ident];
	if(cell == nil) {
		cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident] autorelease];

		cell.textView = [[[UILabel alloc] initWithFrame:cell.bounds] autorelease];
		cell.textView.backgroundColor = [UIColor clearColor];
        cell.textView.numberOfLines = 0;
        cell.textView.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[cell addSubview:cell.textView];
	}

	return cell;
}
	
- (void)dealloc {
	self.textView = nil;
	[super dealloc];
}

@end
