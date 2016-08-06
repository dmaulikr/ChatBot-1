#import <UIKit/UIKit.h>

@protocol SendControllerDelegate

-(void)didSendMessage:(NSString*)text;

@end


@interface SendController : UIViewController {
	UITextView *textView;
	NSString *text;
	id<SendControllerDelegate> delegate;
}

@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) id<SendControllerDelegate> delegate;
@end
