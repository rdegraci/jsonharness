//	Copyright 2011 by Rodney Degracia (rdegraci@gmail.com)
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import "JSONURLConnection.h"


@implementation JSONURLConnection

@synthesize mutableJSONData;
@synthesize delegate;
@synthesize urlString;
@synthesize jsonData;
@synthesize urlConnection;


#pragma mark - NSObject Lifecycle 

-(id)init {
    
    self = [super init];
    if (self) {
		self.mutableJSONData = [[NSMutableData alloc] initWithLength:1024];
    }
    return self;
}


-(id)init:(NSString*)jsonURL {
	
    if ((self = [super init])) {
		self.mutableJSONData = [[NSMutableData alloc] initWithLength:1024];
        
        NSAssert(jsonURL != nil, @"jsonURL is nil!");
        self.urlString = [NSString stringWithFormat:@"%@", jsonURL];
    }
    return self;
}


#pragma mark - Functions

- (void)download {
    
    NSAssert(urlString != nil, @"jsonURL is nil!");
	NSLog(@"Connecting to %@", urlString);
	
	NSURL* url = [NSURL URLWithString:urlString];
	NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:90];
    
	UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
	    
	self.urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
	
	if (urlConnection == nil)
	{		
#ifdef DEBUG
        NSLog(@"Failed to get URL connection.");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to download JSON" message:@"Failed to get URL Connection" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
#endif
	}
}

#pragma mark - NSURLConnection Delegate Methods


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
    
	self.mutableJSONData = [[NSMutableData alloc] initWithLength:0];
	
	return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
    NSLog(@"Receiving %d bytes of data",[data length]);
    
	[mutableJSONData appendData:data];	

}


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
	
	return nil;	//no cache
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
	
    NSLog(@"Succeeded! Received total %d bytes of data",[mutableJSONData length]);
    
    self.jsonData = [NSData dataWithData:mutableJSONData];
    
    NSAssert(delegate != nil, @"delegate is nil!");
    [delegate downloadedJSON:YES urlconnection:self];
    
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	NSString* errormsg = [error localizedDescription];
	NSLog(@"%@ %@", urlString, errormsg);
    
#ifdef DEBUG
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to download JSON" message:errormsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
#endif
    
    
	UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
    
    NSAssert(delegate != nil, @"delegate is nil!");
    [delegate downloadedJSON:NO urlconnection:self];
}

@end
