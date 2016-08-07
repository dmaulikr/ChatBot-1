#import <UIKit/UIKit.h>

@protocol CBTSendControllerDelegate

- (void)didSendMessage:(NSString *)text;

@end

@interface CBTSendViewController : UIViewController

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) id<CBTSendControllerDelegate> delegate;

@end
