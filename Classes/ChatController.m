#import "ChatController.h"
#import "GPNSObjectAdditions.h"
#import "Message.h"
#import "TextViewCell.h"
#import "NSString+SKAdditions.h"


@interface ChatController ()
@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) NSMutableData *startData;
@property(nonatomic,retain) NSMutableData *start2Data;
@property(nonatomic,retain) NSURLConnection *receivedConnection;
@property(nonatomic,retain) NSURLConnection *startConnection;
@property(nonatomic,retain) NSURLConnection *start2Connection;
@property(nonatomic,retain) NSString *botId;
@property(nonatomic,retain) NSString *botcust2;
- (void)requestBotResponse;
- (void)cancelBotResponseRequest;
- (void)addMessage:(NSString*)text fromMe:(BOOL)fromMe;
@end

@implementation ChatController
@synthesize buddy, repository, responses, receivedData, startData, receivedConnection, startConnection, botId, start2Data, start2Connection, botcust2;

- (id)init {
	self = [super initWithStyle:UITableViewStyleGrouped];
	return self;
}

- (void)dealloc {
	[self cancelBotResponseRequest];
	self.buddy = nil;
	self.repository = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark View lifecycle

- (void)loadView {
    NSString *strings[] = {@"I have a question", @"I don't understand what you mean", @"I have a question for you", @"At the end of the day", @"Leet, meaning 'elite'", @"I love you", @"One for all, and all for one", @"Thanks", @"Once", @"I wonder", @"Too easy", @"Too good to be true", @"Too much too handle", @"Too much information", @"Tomorrow", @"Tonight", @"I don't know", @"Lets get high", @"For crying out loud", @"Forever and ever ", @"Foreigner ", @"High-five", @"Sexy", @"Sick", @"Over", @"Hugs and kisses", @"Parent is watching ", @"Anytime, anywhere, anyplace", @"As above", @"As a matter of fact", @"As a friend", @"Asleep at keyboard", @"Alive and kicking", @"As a matter of fact", @"As a matter of interest", @"Always a pleasure", @"At any rate", @"Alive and smiling", @"As always, Sheldon has the answer ", @"Always at the keyboard", @"Already been chewed", @"ALT / CONTROL / DELETE", @"Acknowledge", @"Another day, another dollar", @"All done, bye-bye", @"Another day in hell", @"Another day in paradise", @"Administrator", @"Any day now", @"As early as possible", @"April Fools", @"Away from computer", @"As far as I am aware", @"As far as I am concerned", @"As far as I know", @"As far as I understand it", @"As far as possible", @"April Fool's joke", @"Away from keyboard", @"Acronym Free Zone", @"A fresh pair of eyes", @"At home", @"And I am a money's uncle", @"Alright", @"As I remember", @"As it should be", @"As I said before", @"As I see it", @"Adult in the room", @"Also known as", @"All concerned", @"Actually laughing out loud", @"As much as possible", @"All my best wishes", @"All my love", @"As a matter of fact", @"Available on cell", @"Age of majority", @"All of the above", @"Angel on your pillow", @"All praise and credit", @"Appreciate", @"Acronym rich environment", @"And so it goes", @"As soon as possible", @"At your terminal", @"All the best", @"At the end of the day", @"At the moment", @"All the stars in the sky", @"After awhile crocodile", @"Awesome", @"Away without leaving", @"Absent without leave", @"Are you done yet?", @"At your earliest convenience", @"At your own risk", @"Are you stupid or something?", @"Are you serious?", @"Are you there?", @"And you're telling me this because", @"Are you vertical?", @"As you were", @"As you want", @"As you wish", @"Back to work", @"Boss is watching", @"Boyfriend", @"Before", @"Bye for now", @"Busting a gut", @"Bad *a*", @"Back at keyboard", @"Big 'butt' smile", @"Breathing a sigh of relief", @"Business as usual", @"Back at ya", @"Be back", @"Big bad challenge", @"Be back in a bit", @"Be back in a few", @"Be back in a minute", @"Be back in a sec", @"Be back later", @"Bye, bye now", @"Be back soon", @"Be back tomorrow", @"Because", @"Because", @"Be cool", @"Be seeing you", @"Because", @"Big crush on", @"Big crush on you", @"Big deal", @"Birthday", @"Birthday", @"Big darn number", @"Big evil grin", @"Boyfriend", @"Brain fart", @"Best friend at work", @"Best friend", @"Best friends forever", @"Best friends for life", @"Best friends for life, no matter what", @"Big freaking deal", @"Big  freaking grin", @"Best friend for now", @"Bye for now", @"Big grin", @"Be gentle with me", @"Be home late", @"Boss is back", @"Beer in, beer out", @"Butt in chair", @"Before I forget", @"Burn in hell", @"Brother in law", @"Believe it or not", @"Blow it out your *a*", @"Blow it out your nose", @"But in the meantime", @"Belly laugh", @"Better luck next time", @"Bite me", @"Based on my experience", @"Between me and you", @"Back off *buddy*", @"Bad news", @"Best of luck", @"Be on the look out", @"Bored out of my skull", @"Bending over smacking my knee laughing", @"Back on topic", @"Be on that", @"Boyfriend", @"Big person little mind", @"Be right back", @"Best regards", @"Be right back *babe*", @"Be right back, nature calls", @"Bored", @"Be right here", @"Be right there", @"But seriously folks", @"Blue screen of death", @"Better safe than sorry", @"Bite this", @"Between technologies", @"But then again", @"Been there, done that", @"By the way ", @"Bursting with laughter ", @"Bring your own beer ", @"Bring your own computer", @"Better you than me", @"Chuckle & grin", @"Ciao for now", @"Control + Alt + Delete", @"Coffee break", @"Chat break", @"Crazy *b*", @"Care for secret?", @"Calling for you", @"Coffee in, coffee out", @"Crying in disgrace", @"Consider it done", @"Crying like a baby", @"Call me", @"Call me back", @"Correct me if I'm wrong", @"Come on", @"Close of business", @"Because", @"Cross post", @"Create", @"Can't remember a *freaking* thing", @"Come right back", @"Crying really big tears ", @"Crazy", @"Can't remember *stuff*", @"Chuckle, snicker, grin", @"Can't stop laughing", @"Can't talk", @"Care to chat?", @"Cracking the *heck* up", @"Can't talk now", @"Check this out", @"See you too", @"See you", @"See you", @"See you around", @"See you later", @"See you later alligator", @"See you later", @"See you in my dreams", @"See you around like a donut", @"Complete waste of time", @"Chat with you later", @"See you", @"See you later", @"Check your e-mail", @"See you online", @"Down for sex?", @"Doing business as usual", @"Don't believe everything you read", @"Disconnect", @"Due diligence", @"Don't even go there", @"Don’t go anywhere", @"Don't give a *freak*", @"Don't go there", @"Don't go there, girlfriend", @"Darned if I know", @"Do I know you?", @"Do I look like I give a *freak*?", @"Do I look like I give a sugar?", @"Did I say?", @"Did I tell you I'm distressed?", @"Do it yourself", @"Don't know, don't care", @"Download", @"Down low", @"Don't let the bed bugs bite", @"Doesn't matter", @"Do me", @"Dude Man No Offense", @"Don't mess yourself", @"Down", @"Don't", @"Dude", @"Daughter of Eve", @"Don't quote me on this", @"Didn't read", @"Define the relationship", @"Do the right thing", @"Don't think so", @"Don't touch that dial", @"Duplicate", @"Do you remember?", @"Deviate", @"Dictionary", @"Do you know what you are talking about?", @"Did you find it?", @"Dude, you fascinate me", @"Ecstasy", @"Everyone", @"Easy as one, two, three", @"Ear to ear grin", @"Eating at keyboard", @"Error between keyboard and chair", @"Erase display", @"Effort", @"Evil grin", @"Eat it", @"Editing in progress", @"E-mail address", @"Excuse me for butting in", @"Excuse me for jumping in", @"E-mail message", @"Enough", @"End of day", @"End of discussion", @"End of lecture", @"End of life", @"End of message", @"End of show", @"End of transmission", @"Erase screen", @"Eat *S* and die!", @"Ever", @"Evolution", @"Excitable, yet calm", @"Easy", @"Face to face", @"Falling asleep at keyboard", @"Funny as *freak*", @"Funny as *freak*", @"Frequently asked questions", @"FaceBook", @"FaceBook friend", @"Fine by me", @"For better or worse", @"Fingers crossed", @"For crying out loud", @"*Freak* 'em if they can't take a joke", @"For *freak'*sakes", @"Frankly I couldn't care a less", @"*Freaked* if I know", @"Forget it, I'm out of here", @"Father in law", @"Forever in my heart", @"First in, still here", @"Fill in the blank", @"*Freak* My Life", @"Falling off my chair", @"*Freak* off and die", @"Friend of a friend", @"Falling off my chair laughing", @"For real though", @"From the bottom of my heart", @"For the loss", @"For the win", @"*Freak* you", @"Fouled up beyond all recognition", @"Fouled up beyond belief", @"Forward", @"For what it's worth", @"Fine with me", @"For your eyes only", @"For your amusement", @"For your information", @"Grin", @"Giggle", @"Girlfriend", @"Good to see you", @"Got to go", @"Got to go I'll see you later", @"Got to run", @"Going for coffee", @"Genius", @"Go ahead", @"Get a clue", @"Get a *freaking* clue", @"Get a life", @"Got a second?", @"Greetings and salutations", @"Goodbye", @"Get back to work", @"God bless you", @"Grinning, ducking, and running", @"Grinning, ducking, and running", @"Go for it", @"Girl friend", @"Gone for now", @"Gotta Go", @"Gotta get me some of that", @"Gotta Get Outa Here", @"Got to go pee", @"Give it a rest", @"Garbage in, garbage out", @"Guy in real life", @"Good job", @"Good luck", @"Giggling my butt off", @"Great minds think alike", @"Got my vote", @"Good night", @"Good night everyone", @"Good night", @"Good night", @"Good night, sweet dreams", @"Get over it", @"Giggling out loud", @"Great", @"Congratulations", @"Girl", @"Get right with God", @"Grinning, running and ducking", @"Good shot", @"Good try", @"Get the *freak* out", @"Got to go", @"Going to read mail ", @"Good ", @"Glad we had this little chat", @"Hug", @"Hate", @"Hate to be you", @"Have a good one", @"Hug and kiss", @"How about you?", @"Hugs & kisses", @"Hope to see you soon", @"Have a good night", @"Have a good one", @"Have a nice day", @"Hurry back", @"Hug back", @"Happy Birthday", @"How about you?", @"Have fun", @"Holy flipping animal crackers", @"Happy Father's Day", @"Head hanging in shame", @"Happy Mother's Day", @"Hold on a second", @"How are you?", @"Hope this helps", @"Head up butt", @"Head up your *butt*", @"Have ", @"Homework", @"I already ate", @"I am an accountant", @"I am a doctor", @"I am a lawyer", @"In any case", @"In any event", @"I am not a crook", @"I am not a lawyer", @"I'm back", @"I'm back", @"I see", @"I couldn't agree more", @"It could be worse", @"I can't even discuss it", @"I could fall in love with you", @"I don't believe it", @"I don't care", @"I don't give a *freak*", @"I don't know", @"I don't think so", @"I don't know", @"I feel your pain", @"I got to run", @"I got high tonight", @"I have no idea", @"If I remember correctly", @"Intel inside, idiot outside", @"I know", @"I know, right?", @"I'll be late", @"I love you", @"I love you man", @"I love you", @"Instant message", @"In my arrogant opinion", @"In my humble opinion", @"In my not so humble opinion", @"In my opinion", @"I am sorry", @"I am so bored", @"I am the man", @"I'm not a lawyer", @"In over my head", @"In other words", @"In real life", @"I rest my case", @"I still love you", @"I thought you knew", @"If you say so", @"I will always love you", @"I want a way out", @"Idiot wrapped in a moron", @"If you know what I mean", @"In your opinion", @"If you say so", @"You", @"Your", @"Just a second", @"Just a minutes", @"Just for fun", @"Just *freaking* Google it", @"Just in case", @"Just joking around", @"Just kidding", @"Just let me know", @"Just my opinion", @"Just playing ", @"Just to let you know", @"Just wondering", @"Okay", @"Knock, knock", @"Okay, Okay!", @"Katie", @"Keyboard", @"Keyboard", @"Cool", @"I will key you later", @"Key me when you get in", @"Kiss for you", @"Know it all", @"Keep it simple, stupid", @"Keep in touch", @"Kiss my *a*", @"Kiss my keister", @"Kiss my tushie", @"Kiss on cheek", @"Kiss on cheek", @"Kid over shoulder", @"Knock on wood", @"Kiss on the cheek", @"Kiss on the lips", @"Know what I mean?", @"Keeping parents clueless", @"Katie", @"Keep up the good work", @"Like to go?", @"Like to come", @"Leet, meaning 'elite'", @"Later", @"Later, gator", @"Laughing back at you", @"Later, dude", @"Long distance", @"Like, duh obviously", @"Let me know", @"Leaving easy reach of keyboard", @"Left for day", @"Lets get high", @"Lets have sex", @"Lets have sex", @"Lord help me", @"Laughing head off", @"LinkedIn", @"Like I care", @"Laugh in my tummy", @"Love, later, God bless", @"Laughing like *silly*", @"Laughing my *a* off", @"Laughing my butt off", @"Laughing my freaking *a* off", @"Lets meet in real life", @"Let me know", @"Laughing my mother freaking a** off", @"Leave my name out", @"List of acronyms", @"Laughing out loud", @"Laugh out loud", @"Lots of love", @"Laughing out loud hysterically", @"Lots of love", @"Laughing on the inside", @"Laughing quietly to myself", @"Laugh so hard my belly hurts", @"Language, sex and violence", @"Living the dream", @"Let's twist like we did last summer", @"Long time no see", @"Laptop of death", @"Laughing to self", @"Love you long time", @"Left voice mail", @"Laughing without smiling", @"Love ya ", @"Love you like a sis", @"Love you like crazy", @"Love you so much", @"Microsoft", @"Mate", @"Mamma's boy", @"Mom behind shoulder", @"Merry Christmas %@", @"My Dad is a cop", @"My eyes glaze over", @"Mad for it", @"May God bless", @"Management", @"Meet in real life", @"Mother nature calls", @"Male or female?", @"Mamma's boy", @"My own opinion", @"Member of the opposite sex", @"Mother over shoulder", @"Member of same sex", @"Message", @"More to follow", @"May the force be with you", @"Miss you so much", @"Mind your own business", @"Newbie", @"Nice one", @"Nothing too much", @"Not a darn thing", @"Not a lot of people know that", @"Not now, no need", @"No big deal", @"Any", @"Anyone", @"Not for me", @"Not for sale", @"No *freaking* way", @"Not for work", @"Not for work safe", @"Naked in front of computer", @"Now I get it", @"Not in my back yard", @"Not in reach of keyboard", @"No later than", @"Nothing much", @"Never mind", @"Not much here", @"Nothing much, just chilling", @"Not much, you?", @"No one", @"None of your business", @"No problem", @"Newly qualified teacher", @"No reply necessary", @"No strings attached", @"Not safe for work", @"Not sure if spelled right", @"Nice try", @"Note to self", @"Never mind", @"Never", @"No way", @"No way out", @"Only for you", @"Over", @"Online auctions ", @"On a totally unrelated subject", @"Oh baby", @"Oh brother", @"Overheard", @"Operator indisposed", @"Oh, I'm back", @"Oh, I see", @"Only joking", @"Old lady", @"Online love", @"Old man", @"Oh, my", @"Over my dead body", @"Oh my *freaking* God", @"oh my *freaking* god, laugh my *a* off, owned, roll on floor spinning around I'm so sad", @"Oh my God", @"Oh my God, you got to be kidding", @"On my way", @"Online", @"Over and out", @"Out of character", @"Out of here", @"One of these days", @"Out of the office", @"On phone", @"Oh really?", @"Off to bed", @"On the floor laughing", @"Out to lunch", @"On the other hand", @"On the phone", @"Over the top", @"Off the top of my head", @"Off to work", @"Over", @"On your own", @"Parent to parent", @"Peer to peer", @"Parents coming into room alert", @"Parents are watching", @"Please call me", @"Pretty darn happy", @"Please don't shoot", @"Pretty darn quick", @"People", @"Pretty *freaking* tight", @"Picture", @"Parents in room", @"Put in some sugar", @"Pain in the *butt*", @"Plate", @"Played", @"Please let me know", @"Please", @"People like us", @"Please", @"Please tell me", @"Private Message", @"Pardon me for interrupting", @"Pardon me for jumping in", @"Pee myself laughing", @"Put on a happy face", @"Parent over shoulder", @"Point of view", @"People", @"Pending pick-up", @"Probably", @"Party", @"Parents are watching", @"Parent standing over shoulder", @"Playstation Portable", @"Put that in your pipe and smoke it", @"Praise the Lord", @"Please tell me more", @"Please explain that", @"That stinks!", @"Pretty young thing", @"Peace ", @"Pizza", @"Question for everyone", @"Quoted for idiocy", @"Quoted for irony", @"Quick", @"Quit laughing", @"Quick question", @"Cutie", @"Cutie pie", @"Right back at you", @"Right *freaking* now", @"Rank has its privileges", @"Rest in peace", @"Real life", @"Really", @"Rolling my eyes", @"Read my lips baby", @"Read my mail man", @"Rolling on floor laughing", @"Rolling on floor laughing and spinning around", @"Rolling on the floor, laughing my *butt* off", @"Rolling on the floor laughing", @"Rolling on the floor laughing unable to speak", @"Real soon now", @"Roger that", @"Reason to be single", @"Read the *freaking* manual", @"Read the *freaking* question", @"Read the manual, stupid", @"Read the stupid manual", @"Read the whole *freaking* question", @"Are you?", @"Are you male or female?", @"Are you okay?", @"Regards", @"Real world", @"Read your Bible ", @"Roll your own", @"Read your screen ", @"Are you single?", @"Sorry to say", @"Such a laugh", @"Sorry about that", @"Should be", @"Smiling back", @"Sorry 'bout that", @"Stay cool", @"Sweet dreams, my baby", @"Smiling Ear-to-Ear", @"So far as I know", @"Same here", @"Shut up", @"Slapping head in disgust", @"Sorry, I could not resist", @"Sorry, I got to run", @"Stupidity is hard to take", @"Sorry I missed your call", @"Strike it rich", @"Snickering in silence", @"Stay in touch", @"Sounds like a plan", @"Scratching my head in disbelief", @"Situation normal all fouled up", @"Snot nosed egotistical rude teenager", @"Significant other", @"Son of a *B*", @"Sooner or later", @"Sick of me yet?", @"Straight or Gay?", @"Son of Sam", @"Short of time", @"Short of time, must go", @"Someone with me", @"Seriously", @"Same place, same time", @"Spoke to", @"Square", @"Sorry", @"So sorry", @"Same stuff, different day", @"So stupid it's funny", @"So stupid it's not funny", @"Stop texting and drive", @"Shut the *freak* up", @"Straight", @"Search the Web", @"See you in the morning", @"See you later", @"What's up?", @"Scientific wild *butt* guess", @"Screaming with laughter", @"She who must be obeyed. Meaning wife or partner", @"See you later ", @"See you soon ", @"Shut your yapper", @"Think positive", @"Thanks for being you", @"Think happy thoughts", @"Thanks a lot", @"That's all for now", @"Tomorro a.m.", @"Things Are Really *fouled* Up.", @"Thinking about you miss you always love you", @"To be continued", @"To be determined", @"To be honest", @"Text back later", @"Take care", @"Take care of business", @"Take care of yourself", @"Talk dirty to me", @"Too *freaking* funny", @"Thanks for sharing", @"Thanks for the invitation", @"Thank goodness", @"Thank God it's Friday", @"Thanks", @"Think happy thoughts", @"Thanks", @"Thanks in advance", @"Tomorrow is another day", @"Tongue-in-cheek", @"Tell it like it is", @"Teacher in room", @"Talk to you later", @"Too long", @"Text me back", @"Too much information", @"Trust me on this", @"Too much to handle", @"Take my word for it", @"There's no such thing as a free lunch", @"Til next time", @"Tears of joy", @"Terms of service", @"Thinking of you", @"Thinking of you", @"Tomorrow p.m.", @"The powers that be", @"Tripping so hard", @"That's so not fair", @"The sooner, the better", @"Ta ta for now", @"Totally", @"These things take time", @"Talk to you later", @"Thank you", @"Turning you in", @"That's what she said", @"Time to go", @"Talk to you awhile from now", @"Talk to you later", @"Talk to you soon", @"Thank you", @"Thank you for your comment", @"Told you so", @"Take your time", @"Thank you so much", @"Thank you and *freak* you", @"Thank you very much", @"Up yours", @"You crack me up", @"Ugly domestic scene", @"Un *freaking* believable", @"Until further notice", @"You've got to be kidding", @"You know that's right", @"Use no acronyms", @"Unfortunate", @"Unbelievable", @"Uncertain", @"You are too wise for me", @"You are a star", @"You are so kind to me", @"You are the man", @"You are welcome", @"Until something better comes along", @"Usually", @"You take too long", @"Unpleasant visual", @"You're welcome", @"Very big smile", @"Very evil grin", @"Very freaking funny", @"Value for money", @"Very good condition", @"Very important person", @"Voice mail", @"Very nice", @"Very", @"Very soft chuckle", @"Very sad face", @"What?", @"With", @"Welcome back", @"Wait", @"Working at home", @"What a jerk", @"Wait a minute", @"Want to talk", @"Wait a second", @"Wild *a* guess", @"Where are we at?", @"Where are you from?", @"Write back", @"Welcome back", @"Write back soon", @"What about you?", @"Welcome", @"Who cares", @"Who cares anyway", @"Whatever", @"Weekend", @"Whatever", @"Who, what, when, where, why", @"Wouldn't it be nice if", @"Who died and left you in charge", @"What do you know?", @"What do you think?", @"What do you think?", @"What's in it for me?", @"Winning is so pleasurable", @"What is the point?", @"What in the world", @"Wrap it up", @"Week", @"Weekend", @"With regard to", @"Whatta loser", @"Without", @"Waste of money, brains and time", @"Work", @"Where are you at?", @"What are you doing?", @"What the *freak* ?", @"What the *freak* ever", @"What the *freak* ?, over.", @"Way to go", @"What the heck?", @"Who's the man?", @"What's up?", @"What you see is what you get", @"Where are you from?", @"What's up?", @"What are you up to?", @"What would Jesus do?", @"Will wonders never cease", @"Write when you can", @"Will you call me?", @"When you get a minute", @"When you have a minute", @"When you least expect it", @"What you see is what you get ", @"Wish you were here", @"Kiss", @"Excuse Me", @"Hugs & Kisses", @"Excellent ", @"Examine your zipper", @"Why?", @"You're too kind", @"Your", @"Yet another acronym", @"Yet another bloody acronym", @"Ya, really?", @"Your brother in Christ", @"You'll be sorry", @"You can't do business when your computer is down", @"You can have them", @"You can look it up", @"You crack me up", @"Wife", @"Young gentleman", @"You've got to be kidding me", @"You go girl", @"You have been trolled", @"You have been warned", @"You have lost", @"Yes, I understand", @"You know what", @"You know what you can do", @"Young lady", @"Your mileage may vary", @"You never know", @"Your", @"Yeah right", @"You're running your own cuckoo clock", @"Your sister in Christ", @"Yeah sure you do", @"You there?", @"You're the best", @"Youth talk back", @"You take too long", @"You're the greatest", @"You're welcome", @"Yes, we have no bananas", @"You win some, you lose some", @"Yeah, yeah, sure, sure, whatever", @"Zero", @"Zoo", @"Sleeping Hour", @"Zero tolerance"};
    
	[super loadView];
	NSAssert(self.repository != nil,@"Not initialized");
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)] autorelease];
	self.title = self.buddy.name;
    
    self.responses = malloc(sizeof(self.responses)/sizeof(void*));
    memcpy(strings, self.responses, sizeof(strings)/sizeof(void*));
    
    if(self.useTheBot) [self startTheBot];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	NSInteger section = [self.buddy.messages count];
	if(section > 0)
		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self requestBotResponse];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self cancelBotResponseRequest];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.buddy.messages count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Message *message = [self.buddy.messages objectAtIndex:indexPath.section];
	TextViewCell *cell = [TextViewCell cellForTableView:tableView];
	cell.textView.text = [message text];
	cell.backgroundColor = message.fromMe ? [UIColor whiteColor] : [UIColor colorWithRed:.95 green:.95 blue:1 alpha:1];
										
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UILabel *label = [UILabel xnew];
	label.frame = CGRectMake(18, 0, 290, 20);
	label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor darkGrayColor];
	
	// inset effect
	label.shadowColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:.55];
	label.shadowOffset = CGSizeMake(0.0, 1.0);

	label.text = [[self.buddy.messages objectAtIndex:section] header];

	UIView *view = [UIView xnew];
	[view addSubview:label];
	
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	static int minSize = 32;
	static TextViewCell *dummy = nil;
	if(dummy == nil)
		dummy = [[TextViewCell cellForTableView:nil] retain];
	dummy.textView.text = [[self.buddy.messages objectAtIndex:indexPath.section] text];
    CGSize size = [dummy.textView sizeThatFits:CGSizeMake(320.0, INFINITY)];
    size.height += 12.0;
	return size.height > minSize ? size.height : minSize;
}


#pragma mark -
#pragma mark SendControllerDelegate

- (void)didSendMessage:(NSString*)text {
	[self addMessage:text fromMe:YES];
}

#pragma mark -
#pragma mark Private methods

- (void)responseReceived:(NSString*)response {
	[self addMessage:response fromMe:NO];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if(connection == receivedConnection)
        [receivedData setLength:0];
    else if(connection == startConnection)
        [startData setLength:0];
    else
        [start2Data setLength:0];
        
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    
    if(connection == receivedConnection)
        [receivedData appendData:data];
    else if(connection == startConnection)
        [startData appendData:data];
    else
        [start2Data appendData:data];
            
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    if(connection == receivedConnection) {
        //NSLog(@"Received %@",[[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding:NSUTF8StringEncoding]);         
        NSString *content = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<b>A.L.I.C.E.:<\\/b> *(.*?)<br\\/>" options:0 error:&error];
        NSAssert1(error == nil, @"Regexp error %@", error);
        NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
        NSString *reply = [content substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]];
        NSLog(@"Reply: %@",reply);
        [NSThread sleepForTimeInterval:5]; // don't answer immediately
        [self responseReceived:reply];
    } else if(connection == startConnection) {
        NSLog(@"Succeeded! Received %d bytes of data",[startData length]);
        NSString *content = [[NSString alloc] initWithBytes:[startData bytes] length:[startData length] encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"botid=(\\w+)" options:0 error:&error];
        NSAssert1(error == nil, @"Regexp error %@", error);
        NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
        self.botId = [content substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]];
        NSLog(@"Botid is now %@",self.botId);
        [self startStep2Bot];
    } else {
        NSLog(@"Succeeded! Received %d bytes of data",[start2Data length]);
        NSString *content = [[NSString alloc] initWithBytes:[start2Data bytes] length:[start2Data length] encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"name=\"botcust2\" value=\"(\\w+)" options:0 error:&error];
        NSAssert1(error == nil, @"Regexp error %@", error);
        NSArray *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
        self.botcust2 = [content substringWithRange:[[matches objectAtIndex:0] rangeAtIndex:1]];
        NSLog(@"botcust2 is now %@",self.botcust2);
    }
}

- (void)startTheBot {
    NSString *url = @"http://alice.pandorabots.com";
    NSLog(@"Getting url %@",url);
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    startConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    startData = [[NSMutableData data] retain];
    
}

- (void)startStep2Bot {
    NSString *url = [NSString stringWithFormat:@"http://sheepridge.pandorabots.com/pandora/talk?botid=%@&skin=custom_input",self.botId];
    NSLog(@"Getting url %@",url);
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    start2Connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    start2Data = [[NSMutableData data] retain];
}

- (void)requestBotResponse {
    if(self.botId != nil && self.botcust2 != nil) {
        
        NSString *lastMessage = [[self.buddy.messages lastObject] text];
        NSString *postString = [NSString stringWithFormat:@"input=%@&botcust2=%@",[lastMessage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.botcust2];

        NSString *url = [NSString stringWithFormat:@"http://sheepridge.pandorabots.com/pandora/talk?botid=%@&skin=custom_input",self.botId];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        NSLog(@"Posting url %@\n%@",url,postString);
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

        receivedConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        receivedData = [[NSMutableData data] retain];
    } else {
        [self performSelector:@selector(responseReceived:) withObject:self.responses[rand() % sizeof(self.responses)] afterDelay:rand() % 15 + 2];
    }
}

- (void)cancelBotResponseRequest {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)addMessage:(NSString*)text fromMe:(BOOL)fromMe {
	NSAssert(self.repository != nil, @"Not initialized");
	Message *msg = [self.repository messageForBuddy:self.buddy];
	msg.text = text;
	msg.fromMe = fromMe;
    if(fromMe) {
        [self requestBotResponse];
    }
	[self.repository asyncSave];
	[self.tableView reloadData];
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[self.buddy.messages count] - 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)add:(id)sender {
	SendController *ctrl = [SendController xnew];
	ctrl.delegate = self;
	[self presentModalViewController:[[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease] animated:YES];
}

@end

