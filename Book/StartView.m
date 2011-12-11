//
//  StartView.m
//  Book
//
//  Created by Adrian Lee on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StartView.h"
#import "BookMarkViewController.h"

@interface StartView () 
{
@private
	BookMarkViewController *_bookMarkViewController;
}
@property (strong, nonatomic) BookMarkViewController *bookMarkViewController;

@end

@implementation StartView

@synthesize bookMarkViewController = _bookMarkViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	return self;
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"美食玩家";
	
	// Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	self.bookMarkViewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)statAction:(id)sender {
	[self setBookMarkViewController:[[BookMarkViewController alloc] init]];
	
	[self.navigationController pushViewController:self.bookMarkViewController animated:YES];
}
@end
