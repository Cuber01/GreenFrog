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

This will most likely work only on unix-like systems, because I used / everywhere. 

## Usage

1. This folder goes into anura/modules/frogatto/utils

2. ./run.sh

3. If everything goes right, your svg image should be in your folder. Please note that some svg viewers can't display .png images on svg. If your svg file displays without images, try to open it with Chrome or Firefox.