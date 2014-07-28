spacecat-swift
==============

### About

A Swift version of the Treehouse course app SpaceCat. It was originally created with Xcode 6 beta 2 and completed with beta 4. Note that it doesn't compile with beta2 anymore because of the changes to initialiser inheritance, but you shouldn't be using that version anymore anyway :).
The target SDK is 7.1 which means you can deploy it to current phones without having to get iOS 8 beta.

### Creation

The project isn't a port, rather it has been translated on the fly while I was following along the course. It does use new Swift concepts like optionals, strong typing and extensions but in some parts it may look as an odd mix.


### Differences from the original

There are a lot of subtle differences, I'm just listing the major ones here

* Biggest difference is that the app doesn't use a texture atlas at least for now. Beta 3 introduced a very specific bug with texture atlases that sadly applies here (it was working with beta 2, it only broke after upgrade). Since the project uses a texture atlas seamlessly, I've just removed the atlas from the project and readded images to xcassets. Luckily code didn't have to be modified. Once the bug is fixed these modifications can be undone
* NS_OPTIONS is not directly available to Swift, so I've used an alternative I've found online. Link to details is included in the corresponding file (CollisionCategory.swift)
* The new SpriteKit template uses didMoveToView instead of initWithSize, so I've gone with that, and moved code here compared to the course. If both placed contained code, they've been merged
* I have not used prefixes such as TH originally, neither in file names nor in constants etc.
* I've found a bug with the AI, the variable minSpeed is created and updated based on gameplay time, however the constant value is used to determine the minimum speed instead, thus the game doesn't get harder. Feel free to revert if you don't like it :)

### Licensing

I've chosen the MIT license but to be honest I don't care about licensing, do what you want with it. The original version wasn't mine to begin with anyway.
