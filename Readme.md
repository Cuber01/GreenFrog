# GreenFrog

GreenFrog is a tool used to generate a simplified version of [Frogatto](https://github.com/frogatto/frogatto) progression with the first appearence of every enemy marked.

## Dependencies:

* Ruby (tested on 2.7) - For running the whole program
* victor gem for ruby - For generating svg images
* mini_magick gem for ruby - For image editing
* ImageMagick or GraphicsMagic terminal tool - For image editing
* json gem for ruby - For reading .json files
* A copy of Frogatto (tested on dev branch from April 24 2021)

## Known Issues

This thing still cannot find enemies spawned in events, like ambushes. Because of this, it won't display some enemies (like most bosses). 
