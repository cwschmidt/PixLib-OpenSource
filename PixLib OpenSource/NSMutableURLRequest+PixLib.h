/*
 * Copyright (c) 2013 pixelflut GmbH, http://pixelflut.net
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 */

//
//  NSMutableURLRequest+PixLib.h
//  PixLib OpenSource
//
//  Created by Jonathan Cichon on 18.02.13.
//

#import <Foundation/Foundation.h>

/**
 * Adds convinient methods for creating URLRequests with Strings
 */
@interface NSMutableURLRequest (PixLib)

/** Creates a new request with the given url.
 @param urlStr The url as string.
 @return the newly created request.
 */
+ (NSMutableURLRequest*)requestWithUrlString:(NSString*)urlStr;

/** Creates a new request with the given url with optional base-auth.
 @param urlStr The url as string.
 @param user The username used for basic-auth.
 @param password The password used for basic-auth
 @return the newly created request.
 */
+ (NSMutableURLRequest*)requestWithUrlString:(NSString*)urlStr user:(NSString*)user password:(NSString*)password;

/** sets some generic Device-informations to the http-header field 'Px-Agent'.
 @see [UIDevice(PixLib) agentIdentifier]
 */
- (void)addPxAgent;

@end
