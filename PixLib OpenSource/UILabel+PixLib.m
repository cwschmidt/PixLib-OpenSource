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
//  UILabel+PixLib.m
//  PixLib OpenSource
//
//  Created by Jonathan Cichon on 18.02.13.
//

#import "UILabel+PixLib.h"
#import "PxCore.h"

@implementation UILabel (PixLib)

- (id)initWithFrame:(CGRect)frame fontConfig:(PxFontConfig)fontConfig {
    self = [self initWithFrame:frame];
    if (self) {
        self.font = fontConfig.font;
        
        if ([self respondsToSelector:@selector(minimumScaleFactor)]) {
            self.minimumScaleFactor = fontConfig.minimumScaleFactor;
        } else if([self respondsToSelector:@selector(minimumFontSize)]) {
            [self setMinimumFontSize:fontConfig.minimumScaleFactor];
        }
        
        self.lineBreakMode = fontConfig.lineBreakMode;
        self.adjustsFontSizeToFitWidth = fontConfig.adjustsFontSizeToFitWidth;
        self.numberOfLines = fontConfig.numberOfLines;
    }
    return self;
}

- (PxFontConfig)fontConfig {
    if ([self respondsToSelector:@selector(minimumScaleFactor)]) {
        return PxFontConfigMake(self.font, self.minimumScaleFactor, self.lineBreakMode, self.adjustsFontSizeToFitWidth, self.numberOfLines);
    } else if([self respondsToSelector:@selector(minimumFontSize)]){
        return PxFontConfigMake(self.font, self.minimumFontSize, self.lineBreakMode, self.adjustsFontSizeToFitWidth, self.numberOfLines);
    }
    return PxFontConfigMake(self.font, 0.0, self.lineBreakMode, self.adjustsFontSizeToFitWidth, self.numberOfLines);
}

- (float)heightToFitWidth:(float)width {
    return [self.text heightForWidth:width config:self.fontConfig];
}

- (float)heightToFit {
	return [self heightToFitWidth:self.frame.size.width];
}

- (void)setHeightToFitWidth:(float)width {
    [self setSize:CGSizeMake(width, [self heightToFitWidth:width])];
}

- (void)setHeightToFit {
    [self setHeightToFitWidth:self.frame.size.width];
}

- (float)widthToFitHeight:(float)height {
    return [[self text] sizeWithFont:[self font] constrainedToSize:CGSizeMake(INT_MAX, height) lineBreakMode:[self lineBreakMode]].width;
}

- (float)widthToFit {
	return [self widthToFitHeight:self.frame.size.height];
}

- (void)setWidthToFitHeight:(float)height {
    [self setSize:CGSizeMake([self widthToFitHeight:height], height)];
}

- (void)setWidthToFit {
    [self setWidthToFitHeight:self.frame.size.height];
}

- (void)sizeToFit {
	[self setSize:CGSizeMake([self widthToFit], [self heightToFit])];
}

- (void)sizeToFitWithMaxWidth:(int)maxWidth {
	[self sizeToFit];

	if(self.frame.size.width > maxWidth) {
		[self setHeightToFitWidth:maxWidth];
	}
}


#pragma mark - Wrapper for deprecated methods

- (void)setMinimumScaleFactorIfAvailable:(float)minimumScaleFactor {
	if([self respondsToSelector:@selector(setMinimumScaleFactor:)]) {
		[(id)self setMinimumScaleFactor:minimumScaleFactor];
	} else if([self respondsToSelector:@selector(setMinimumFontSize:)]) {
		[(id)self setMinimumFontSize:(int)self.font.pointSize*minimumScaleFactor];
	}
}

- (void)setAdjustsLetterSpacingToFitWidthIfAvailable:(BOOL)adjustLetterSpacingToFitWidth {
	if([self respondsToSelector:@selector(setAdjustsLetterSpacingToFitWidth:)]) {
		[(id)self setAdjustsLetterSpacingToFitWidth:adjustLetterSpacingToFitWidth];
	}
}

@end