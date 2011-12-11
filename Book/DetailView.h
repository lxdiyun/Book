//
//  DetailView.h
//  Book
//
//  Created by Adrian Lee on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIViewController
{
@private
	NSString *_textString;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *textString;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)layoutScrollImages;

@end
