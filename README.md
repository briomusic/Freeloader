# freeloader
swift package based sound preview

##Background
I am in the process of refactoring my aging Appstore Project `Cloudsynth`.  
Cloudsynth is a sample player, initially based on the SoundCloud.com sound library.

I want to provide the user additional services like Freesound.com to download sounds from, so I started to refactor the whole Sound Download System, which I now present as a testable stand-alone project.

##Technology
1. **Swift** (replacing Obj-C)
2. **Local Swift Packages** (replacing a monolithic project file)
3. **Remote Swift Packages** (replacing Cocoapods)
4. **NSDiffableDatasource** (replacing UITableViewDataSource)

##Usage
- Start the `FreesoundTester.xcodeproj`	 
- Enter a search term (for example `bass` or  `guitar`)    
- Tap return  
- When the search is complete a table of downloadable sounds is presented
- Tap on the `play` button to preview the sound
- (The `download` button is not implemented outside `Cloudsynth`)

###Credit
- I show the `JGProgressHUD` while loading
- I borrowed `MKImageDownloader` by Mohit Kumar to asynchronously load the waveform images.
