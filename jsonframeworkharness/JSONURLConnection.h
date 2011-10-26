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

#import <Foundation/Foundation.h>


@protocol  JSONURLConnectionDelegate;

@interface JSONURLConnection : NSObject {
    
	NSMutableData* mutableJSONData;
	NSData* jsonData;
	id <JSONURLConnectionDelegate> delegate;
    NSURLConnection* urlConnection;    
}
@property(nonatomic, retain) NSMutableData* mutableJSONData;
@property(nonatomic, retain) id <JSONURLConnectionDelegate>  delegate;
@property(nonatomic, retain) NSString* urlString;
@property(nonatomic, retain) NSData* jsonData;
@property(nonatomic, retain) NSURLConnection* urlConnection;

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)download;
- (id)init:(NSString*)jsonURL;
@end

@protocol JSONURLConnectionDelegate
- (void)downloadedJSON:(BOOL)result urlconnection:(JSONURLConnection*)connection;
@end
