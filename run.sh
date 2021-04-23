#!/bin/sh

# Get data about enemies
ruby Data.rb > Enemies.json

# Sort Progression.json if needed
ruby Sort.rb > ProgressionSorted.json

# Prepare Images
ruby svg_generation/image_preparation/PrepareImages.rb

# Make svg!
ruby svg_generation/svg.rb


