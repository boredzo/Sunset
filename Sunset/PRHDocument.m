#import "PRHDocument.h"

@interface PRHDocument ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation PRHDocument

- (id) init {
	self = [super init];
	if (self) {
		self.text = @"";
	}
	return self;
}

- (NSString *) windowNibName {
	return @"PRHDocument";
}

- (void) windowControllerDidLoadNib:(NSWindowController *)aController {
	[super windowControllerDidLoadNib:aController];

	NSColor *pink = [NSColor colorWithCalibratedHue:300.0/360.0
	                                     saturation:1.0
	                                     brightness:1.0
			                                  alpha:1.0];
	NSColor *violet = [NSColor colorWithCalibratedHue:280.0/360.0
	                                     saturation:1.0
			                             brightness:1.0
						                      alpha:1.0];
	NSColor *bottomColor = pink;
	NSColor *topColor = violet;
	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:bottomColor endingColor:topColor];

	self.textView.textColor = [NSColor whiteColor];
	NSSize size = { 1.0, 10000.0 };
	self.textView.backgroundColor = [NSColor colorWithPatternImage:[NSImage imageWithSize:size
	                                                                              flipped:NO
		                                                                   drawingHandler:^BOOL(NSRect dstRect) {
			                                                                   [gradient drawFromPoint:NSZeroPoint
			                                                                                   toPoint:(NSPoint){ 0.0, 64.0 }
				                                                                               options:NSGradientDrawsAfterEndingLocation];
			                                                                   return YES;
		                                                                   }]];
}

+ (BOOL) autosavesInPlace {
	return YES;
}

- (NSData *) dataOfType:(NSString *)typeName error:(NSError **)outError {
	return [self.text dataUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL) readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
	self.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	bool success = (self.text != nil);
	if (!success) {
		if (outError) {
			*outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadInapplicableStringEncodingError
			                            userInfo:nil];
		}
	}
	return success;
}

@end
