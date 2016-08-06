#import "SendController.h"


@implementation SendController
@synthesize textView, text, delegate;

- (void)dealloc {
	self.textView = nil;
	self.text = nil;
	self.delegate = nil;
    [super dealloc];
}

- (void)loadView {
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(send:)] autorelease];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];
	
	self.textView = [[[UITextView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
	textView.text=text;

	self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
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
