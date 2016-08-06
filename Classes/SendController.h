#import <UIKit/UIKit.h>

@protocol SendControllerDelegate

-(void)didSendMessage:(NSString*)text;

@end


@interface SendController : UIViewController {
	UITextView *textView;
	NSString *text;
	id<SendControllerDelegate> __weak delegate;
}

@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,weak) id<SendControllerDelegate> delegate;
@end
