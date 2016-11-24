![Logo](./README_FILES/Logo.png)

# Gallery — An image downloading and caching library

Gallery is a image downloading and caching library that downloads an image from a `URL` for easy use in your apps. 

## Setup

Before using Gallery it needs to be set up. This can be done in your `AppDelegate` by running `Gallery.setup()`.

Gallery can also be customised before setup. This allows you to change the caching folder name, or turn of caching entirely.

``` swift
Gallery.galleryFolderName = "FolderName"
Gallery.shouldCache = true
Gallery.setup()
```

You can also set a placeholder image to be used when an image is loading and as a fallback if the image loading fails.

```swift
Gallery.placeHolderImage = myImage
```

## Loading

Once Gallery has been setup it's very easy to use. Just call the method:

```swift
Gallery.getImage(for: URL, startImmediately: Bool, completion: (ImageResult) -> ()) -> ArtLoader
```

This method takes the `URL` of the image to load, whether it should begin loading straight away, and a competion handler that is called once the loading has finished. It also returns an `ArtLoader` object that can be used to start and stop the request should it be desired. 

The completion handler has an `ImageResult` object which is an enum. It has two states:

```swift
.success(UIImage)
.failure(Error)
```

If the image downloaded correctly it will be `.success` and will contain the image file, other wise it will be called with `.failure`.

Here is an example use of the library:

``` swift
Gallery.getImage(for: imageUrl, startImmediately: true) { result in
	switch result {
    case let .success(image):
		imageView.image = image
	case let .failure(error):
		print(error)
		break
	}
}
```

## UIImageView Extension

To make using Gallery even easier with `UIImageView`s there is an extension method called `loadGalleryImage(from: URL)` which will take a url and load it straight in to the image view. Here is what it looks like in practice:

``` swift
imageView.loadGalleryImage(from: imageUrl)
```

This method also returns an `ArtLoader` object so that loading can be controlled. **Note that this method will start loading the image straight away.**

There are also overload methods that allow you to set a different placeholder image to the one set in Gallery, or call a completion handler when the loading of an image has finished.

```swift
// Load with placeholder image
imageView.loadGalleryImage(from: imageUrl, placeHolder: newPlaceHolderImage)

// Load with completion handler
coverImageView.loadGalleryImage(from: url) {
	// completion handler here
}
```

Or even both at the same time!

``` swift
// Both at the same time
imageView.loadGalleryImage(from: imageUrl, placeHolder: placeholderImage) {
	// do stuff here
}
```

