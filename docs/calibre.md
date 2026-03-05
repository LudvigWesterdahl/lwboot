
- Try if this works.
- create script in Scripts repo: epub-util kindle <file.epub>

Example:
textebook-convert "My Book.epub" "My Book.azw3"
Sending to Device (Kindle via USB)
Calibre does not have a direct CLI command to "send to device" like the GUI's "Send to device" button, which handles proper placement, metadata, covers, and Kindle-specific files (e.g., thumbnails, page numbers via .apnx).
Option 1: Simple Copy (No Full Metadata Integration)

Connect your Kindle via USB (it mounts as a drive, e.g., E:\ on Windows or /Volumes/Kindle on macOS/Linux).
Manually copy the .azw3 file to the documents folder on the Kindle.
