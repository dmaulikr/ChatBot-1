#import "CBTSendViewController.h"


@implementation CBTSendViewController
@synthesize textView, text, delegate;

- (void)dealloc {
	self.delegate = nil;
}

- (void)loadView {
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(send:)];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
	
	self.textView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	textView.text=text;

	self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[self.view addSubview:textView];

	[textView becomeFirstResponder];
}

- (void)send:(id)sender {
	[self.textView resignFirstResponder]; // apply pending auto corrections
	[delegate didSendMessage:self.textView.text];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end
