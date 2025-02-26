//
//  ImageUtils.m
//  RNBluetoothEscposPrinter
//
//  Created by januslo on 2018/10/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageUtils.h"
#import <Accelerate/Accelerate.h>

@implementation ImageUtils : NSObject
int p0[] = { 0, 0x80 };
int p1[] = { 0, 0x40 };
int p2[] = { 0, 0x20 };
int p3[] = { 0, 0x10 };
int p4[] = { 0, 0x08 };
int p5[] = { 0, 0x04 };
int p6[] = { 0, 0x02 };

+ (UIImage*)imagePadLeft:(NSInteger) left withSource: (UIImage*)source
{
    CGSize orgSize = [source size];
    CGSize size = CGSizeMake(orgSize.width + [[NSNumber numberWithInteger: left] floatValue], orgSize.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    [source drawInRect:CGRectMake(left, 0, orgSize.width, orgSize.height)
             blendMode:kCGBlendModeNormal alpha:1.0];
    UIImage *paddedImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return paddedImage;
}

// +(uint8_t *)imageToGreyImage:(UIImage *)image {
//     // Create image rectangle with current image width/height
//     int kRed = 1;
//     int kGreen = 2;
//     int kBlue = 4;

//     int colors = kGreen | kBlue | kRed;

//     CGFloat actualWidth = image.size.width;
//     CGFloat actualHeight = image.size.height;
//     NSLog(@"actual size: %f,%f",actualWidth,actualHeight);
//     uint32_t *rgbImage = (uint32_t *) malloc(actualWidth * actualHeight * sizeof(uint32_t));
//     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//     CGContextRef context = CGBitmapContextCreate(rgbImage, actualWidth, actualHeight, 8, actualWidth*4, colorSpace,
//                                                  kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
//     CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
//     CGContextSetShouldAntialias(context, NO);
//     CGContextDrawImage(context, CGRectMake(0, 0, actualWidth, actualHeight), [image CGImage]);
//     CGContextRelease(context);
//     CGColorSpaceRelease(colorSpace);
    
//         int width = image.size.width;
//     int height = image.size.height;
//     uint8_t *m_imageData = (uint8_t *) malloc(width * height);
//    // NSMutableString *toLog = [[NSMutableString alloc] init];
//     for(int y = 0; y < actualHeight; y++) {
//         for(int x = 0; x < actualWidth; x++) {
//         //     uint32_t rgbPixel=rgbImage[(int)(y*actualWidth+x)];
//         //     uint32_t sum=0,count=0;
//         //     if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
//         //     if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
//         //     if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
//         //    // [toLog appendFormat:@"pixel:%d,sum:%d,count:%d,val:%d;",rgbPixel,sum,count,(int)(sum/count)];
//         //     m_imageData[(int)(y*actualWidth+x)]=sum/count;

//                  uint32_t rgbPixel = rgbImage[(y * width) + x];
//             uint8_t gray = ((rgbPixel >> 16) & 0xFF) * 0.3 + ((rgbPixel >> 8) & 0xFF) * 0.59 + (rgbPixel & 0xFF) * 0.11;
            
//             // Chuyển từ grayscale (8-bit) về nhị phân (1-bit)
//             m_imageData[(y * width) + x] = (gray > 128) ? 255 : 0;
           
//         }
//     }
//     return m_imageData;
// }


+(uint8_t *)imageToGreyImage:(UIImage *)image {
//     // Create image rectangle with current image width/height
//     int kRed = 1;
//     int kGreen = 2;
//     int kBlue = 4;

//     int colors = kGreen | kBlue | kRed;

//     CGFloat actualWidth = image.size.width;
//     CGFloat actualHeight = image.size.height;
//     NSLog(@"actual size: %f,%f",actualWidth,actualHeight);
//     uint32_t *rgbImage = (uint32_t *) malloc(actualWidth * actualHeight * sizeof(uint32_t));
//     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//     CGContextRef context = CGBitmapContextCreate(rgbImage, actualWidth, actualHeight, 8, actualWidth*4, colorSpace,
//                                                  kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
//     CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
//     CGContextSetShouldAntialias(context, NO);
//     CGContextDrawImage(context, CGRectMake(0, 0, actualWidth, actualHeight), [image CGImage]);
//     CGContextRelease(context);
//     CGColorSpaceRelease(colorSpace);
    
//         int width = image.size.width;
//     int height = image.size.height;
//     uint8_t *m_imageData = (uint8_t *) malloc(width * height);
//    // NSMutableString *toLog = [[NSMutableString alloc] init];
//     for(int y = 0; y < actualHeight; y++) {
//         for(int x = 0; x < actualWidth; x++) {
//         //     uint32_t rgbPixel=rgbImage[(int)(y*actualWidth+x)];
//         //     uint32_t sum=0,count=0;
//         //     if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
//         //     if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
//         //     if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
//         //    // [toLog appendFormat:@"pixel:%d,sum:%d,count:%d,val:%d;",rgbPixel,sum,count,(int)(sum/count)];
//         //     m_imageData[(int)(y*actualWidth+x)]=sum/count;

//                  uint32_t rgbPixel = rgbImage[(y * width) + x];
//             uint8_t gray = ((rgbPixel >> 16) & 0xFF) * 0.3 + ((rgbPixel >> 8) & 0xFF) * 0.59 + (rgbPixel & 0xFF) * 0.11;
            
//             // Chuyển từ grayscale (8-bit) về nhị phân (1-bit)
//             m_imageData[(y * width) + x] = (gray > 128) ? 1 : 0;
           
//         }
//     }
//     return m_imageData;


    int width = image.size.width;
    int height = image.size.height;
    uint8_t *m_imageData = (uint8_t *) malloc(width * height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(m_imageData, width, height, 8, width, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [image CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Áp dụng threshold ngay tại đây để giảm vòng lặp
    for (int i = 0; i < width * height; i++) {
        m_imageData[i] = (m_imageData[i] < 140) ? 0 : 255; // Ngưỡng đậm hơn để in rõ nét
    }
    
    return m_imageData;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size {
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);

    NSLog(@"🔍 Ảnh sau khi resize: scale = %.2f, width = %.2f, height = %.2f, imageRect = %.2f", scale, width, height, imageRect);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(uint8_t *)convertToGrayscale:(UIImage *)image width:(size_t)width height:(size_t)height{
    if (!image) return NULL;

    // 1️⃣ Xác định tọa độ vùng cần cắt
    CGFloat xMin = 10;  // Giá trị x bắt đầu cắt (có thể thay đổi)
    CGFloat yMin = 10;  // Giá trị y bắt đầu cắt (có thể thay đổi)
    CGFloat newWidth = width - xMin;
    CGFloat newHeight = height - yMin;

    // 2️⃣ Cắt ảnh
    CGRect cropRect = CGRectMake(xMin, yMin, newWidth, newHeight);
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedImageRef];
    CGImageRelease(croppedImageRef);

    // 3️⃣ Chuyển đổi ảnh đã cắt thành grayscale
    size_t croppedWidth = CGImageGetWidth(croppedImage.CGImage);
    size_t croppedHeight = CGImageGetHeight(croppedImage.CGImage);
    size_t bytesPerRow = croppedWidth * 4; // 4 bytes per pixel (RGBA)
    
    uint8_t *rgbData = (uint8_t *)malloc(croppedWidth * croppedHeight * 4);
    uint8_t *grayData = (uint8_t *)malloc(croppedWidth * croppedHeight);

    if (!rgbData || !grayData) {
        free(rgbData);
        free(grayData);
        return NULL;
    }

    // 4️⃣ Tạo context để lấy dữ liệu ảnh vào rgbData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbData, croppedWidth, croppedHeight, 8, bytesPerRow, colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Little);
    CGContextDrawImage(context, CGRectMake(0, 0, croppedWidth, croppedHeight), croppedImage.CGImage);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    // 5️⃣ Chuyển đổi sang grayscale
    vImage_Buffer srcBuffer = { .data = rgbData, .width = croppedWidth, .height = croppedHeight, .rowBytes = bytesPerRow };
    vImage_Buffer destBuffer = { .data = grayData, .width = croppedWidth, .height = croppedHeight, .rowBytes = croppedWidth };

    // vImageConvert_RGB888toGrayscale(&srcBuffer, &destBuffer, NULL, kvImageNoFlags);

    // Giải phóng bộ nhớ
    free(rgbData);

    return grayData;  // Trả về dữ liệu ảnh grayscale đã cắt
}

// +(uint8_t *)convertToGrayscale:(UIImage *)image width:(size_t)width height:(size_t)height {
//     // if (!image) return NULL; // Kiểm tra ảnh NULL tránh crash
    
//     // 1️⃣ Tạo buffer cho ảnh gốc (RGBA)
//     // size_t bytesPerRow = width * 4; // 4 bytes per pixel (RGBA)
//     // uint8_t *rgbData = (uint8_t *)malloc(width * height * 4);
//     // uint8_t *grayData = (uint8_t *)malloc(width * height);
    
//     // if (!rgbData || !grayData) {
//     //     free(rgbData);
//     //     free(grayData);
//     //     return NULL;
//     // }
    
//     // 2️⃣ Tạo context để lấy dữ liệu ảnh vào rgbData
//     // CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//     // CGContextRef context = CGBitmapContextCreate(rgbData, width, height, 8, bytesPerRow, colorSpace, kCGImageAlphaNoneSkipLast | kCGBitmapByteOrder32Little);
//     // CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
//     // CGContextRelease(context);
//     // CGColorSpaceRelease(colorSpace);
    
//     // // 3️⃣ Tạo vImage buffer cho RGB
//     // vImage_Buffer srcBuffer = { .data = rgbData, .width = width, .height = height, .rowBytes = bytesPerRow };
//     // vImage_Buffer smoothBuffer = { .data = malloc(width * height * 4), .width = width, .height = height, .rowBytes = bytesPerRow };

//     // if (!smoothBuffer.data) {
//     //     free(rgbData);
//     //     free(grayData);
//     //     return NULL;
//     // }
    
//     // // 4️⃣ Làm mịn ảnh bằng bộ lọc Gaussian Box 3x3
//     // vImageBoxConvolve_ARGB8888(&srcBuffer, &smoothBuffer, NULL, 0, 0, 3, 3, NULL, kvImageEdgeExtend);
    
//     // // 5️⃣ Chuyển đổi RGB sang grayscale
//     // vImage_Buffer destBuffer = { .data = grayData, .width = width, .height = height, .rowBytes = width };
//     // vImageConvert_ARGB8888toPlanar8(&smoothBuffer, &destBuffer, NULL, kvImageNoFlags);
    
//     // // 6️⃣ Giải phóng bộ nhớ
//     // free(rgbData);
//     // free(smoothBuffer.data);
    
//     // return grayData; // Trả về ảnh grayscale đã được làm mịn
//     return NULL
// }

+ (NSData*)bitmapToArray:(UIImage*) bmp
{
    CGDataProviderRef provider = CGImageGetDataProvider(bmp.CGImage);
    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    return data;
}

/**
 **Raster Image - $1D $76 $30 m xL xH yL yH d1...dk
 Prints a raster image
 
 Format:
 Hex       $1D  $76 30  m xL xH yL yH d1...dk
 
 ASCII     GS   v   %   m xL xH yL yH d1...dk
 
 Decimal   29  118  48  m xL xH yL yH d1...dk
 
 Notes:
 When ​standard mode​ is enabled, this command is only executed when there is no data in the print buffer. (Line is empty)
 The defined data (​d​) defines each byte of the raster image. Each bit in every byte defines a pixel. A bit set to 1 is printed and a bit set to 0 is not printed.
 If a raster bit image exceeds one line, the excess data is not printed.
 This command feeds as much paper as is required to print the entire raster bit image, regardless of line spacing defined by 1/6” or 1/8” commands.
 After the raster bit image is printed, the print position goes to the beginning of the line.
 The following commands have no effect on a raster bit image:
 Emphasized
 Double Strike
 Underline
 White/Black Inverse Printing
 Upside-Down Printing
 Rotation
 Left margin
 Print Area Width
 A raster bit image data is printed in the following order:
 d1    d2    …    dx
 dx + 1    dx + 2    …    dx * 2
 .    .    .    .
 …    dk - 2    dk - 1    dk
 Defines and prints a raster bit image using the mode specified by ​m​:
 m    Mode    Width Scalar    Heigh Scalar
 0, 48    Normal    x1    x1
 1, 49    Double Width    x2    x1
 2, 50    Double Height    x1    x2
 3, 51    Double Width/Height    x2    x2
 xL, xH ​defines the raster bit image in the horizontal direction in ​bytes​ using two-byte number definitions. (​xL + (xH * 256)) Bytes
 yL, yH ​defines the raster bit image in the vertical direction in ​dots​ using two-byte number definitions. (​yL + (yH * 256)) Dots
 d ​ specifies the bit image data in raster format.
 k ​indicates the number of bytes in the bit image. ​k ​is not transmitted and is there for explanation only.
 **/
+ (NSData *)eachLinePixToCmd:(unsigned char *)src nWidth:(NSInteger) nWidth nHeight:(NSInteger) nHeight nMode:(NSInteger) nMode
{
    NSLog(@"SIZE OF SRC: %lu",sizeof(&src));
    NSInteger nBytesPerLine = (int)nWidth/8;
    unsigned char * data = malloc(nHeight*(8+nBytesPerLine));
   // const char* srcData = (const char*)[src bytes];
    NSInteger k = 0;
   // NSMutableString *toLog = [[NSMutableString alloc] init];
    for(int i=0;i<nHeight;i++){
        NSInteger var10 = i*(8+nBytesPerLine);
         //GS v 0 m xL xH yL yH d1....dk 打印光栅位图
                data[var10 + 0] = 29;//GS
                data[var10 + 1] = 118;//v
                data[var10 + 2] = 48;//0
                data[var10 + 3] =  (unsigned char)(nMode & 1);
                data[var10 + 4] =  (unsigned char)(nBytesPerLine % 256);//xL
                data[var10 + 5] =  (unsigned char)(nBytesPerLine / 256);//xH
                data[var10 + 6] = 1;//yL
                data[var10 + 7] = 0;//yH
//        for(int l=0;l<8;l++){
//            NSInteger d =data[var10 + l];
//            [toLog appendFormat:@"%ld,",(long)d];
//        }
        
        for (int j = 0; j < nBytesPerLine; ++j) {
            data[var10 + 8 + j] = (int) (p0[src[k]] + p1[src[k + 1]] + p2[src[k + 2]] + p3[src[k + 3]] + p4[src[k + 4]] + p5[src[k + 5]] + p6[src[k + 6]] + src[k + 7]);
            k =k+8;
             //  [toLog appendFormat:@"%ld,",(long)data[var10+8+j]];
        }
       // [toLog appendString:@"\n\r"];
    }
   // NSLog(@"line datas: %@",toLog);
    return [NSData dataWithBytes:data length:nHeight*(8+nBytesPerLine)];
}

+(unsigned char *)format_K_threshold:(unsigned char *) orgpixels
                        width:(NSInteger) xsize height:(NSInteger) ysize
{
    unsigned char * despixels = malloc(xsize*ysize);
    int graytotal = 0;
    int k = 0;
    
    int i;
    int j;
    int gray;
    for(i = 0; i < ysize; ++i) {
        for(j = 0; j < xsize; ++j) {
            gray = orgpixels[k] & 255;
            graytotal += gray;
            ++k;
        }
    }
    
    int grayave = graytotal / ysize / xsize;
    k = 0;
   // NSMutableString *logStr = [[NSMutableString alloc]init];
   // int oneCount = 0;
    for(i = 0; i < ysize; ++i) {
        for(j = 0; j < xsize; ++j) {
            gray = orgpixels[k] & 255;
            if(gray > grayave) {
                despixels[k] = 0;
            } else {
                despixels[k] = 1;
               // oneCount++;
            }
            
            ++k;
           // [logStr appendFormat:@"%d,",despixels[k]];
        }
    }
   // NSLog(@"despixels [with 1 count:%d]: %@",oneCount,logStr);
    return despixels;
}
+(NSData *)pixToTscCmd:(uint8_t *)src width:(NSInteger) width
{
    int length = (int)width/8;
    uint8_t * data = malloc(length);
    int k = 0;
    for(int j = 0;k<length;++k){
        data[k] =(uint8_t)(p0[src[j]] + p1[src[j + 1]] + p2[src[j + 2]] + p3[src[j + 3]] + p4[src[j + 4]] + p5[src[j + 5]] + p6[src[j + 6]] + src[j + 7]);
        j+=8;
    }
    return [[NSData alloc] initWithBytes:data length:length];
}

@end
