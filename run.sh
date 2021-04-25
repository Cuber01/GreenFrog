#!/bin/sh

echo "Start"

# Get data about enemies
echo "Getting data about enemies..."
ruby Data.rb > Enemies.json

# Sort Progression.json if needed
echo "Sorting progression..."
ruby Sort.rb > ProgressionSorted.json

# Prepare Images
echo "Editing images..."
ruby ./svg_generation/image_preparation/PrepareImages.rb

# Make svg!
echo "Generating svg..."
ruby ./svg_generation/svg.rb

echo "Done."
