# GoPro Concatenator
```
   ___       ___
 / ___| ___ |  _ \ _ __ ___
| |  _ / _ \| |_) | '__/ _ \
| |_| | (_) |  __/| | | (_) |
 \____|\___/|_|   |_|  \___/_                   _
 / ___|___  _ __   ___ __ _| |_ ___ _ __   __ _| |_ ___  _ __
| |   / _ \| '_ \ / __/ _` | __/ _ \ '_ \ / _` | __/ _ \| '__|
| |__| (_) | | | | (_| (_| | ||  __/ | | | (_| | || (_) | |
 \____\___/|_| |_|\___\__,_|\__\___|_| |_|\__,_|\__\___/|_|

```
## Pre-requisites ##
1. GoPro video files: "GX....MP4"
2. [Quick app](https://gopro.com/en/us/shop/quik-app-video-photo-editor) to transfer videos from the camera to your computer
3. ffmpeg
   
## Installation ##
1. Install ffmpeg
   - Ubuntu/Debian (Linux)
     ```bash
     sudo apt update
     sudo apt install ffmpeg
     ```
   - Fedora (Linux)
     ```bash
     sudo dnf install ffmpeg
     ```
   - CentOS/RHEL (Linux)
     ```bash
     sudo dnf install epel-release
     sudo dnf install https://rpmfusion.org/free-release/rpmfusion-free-release-8.noarch.rpm
     sudo dnf install ffmpeg ffmpeg-devel
     ```
   - Arch Linux
     ```bash
     sudo pacman -S ffmpeg
     ```
   - macOS
     ```bash
     brew install ffmpeg
     ```
2. Transfer the videos from your GoPro camera into a folder in your computer (eg ~/Videos/), keep the originals elsewhere, just in case.
3. Clone this repository and copy or download the file video_edit.sh into that same folder
4. In that folder, run the script video_edit.sh:
  - Ubuntu/Debian, Fedora, CentOS/RHEL, Arch, macOS
     ```bash
     chmod +x video_edit.sh
     ./video_edit.sh
     ```
## Run video_edit ##
1. You will be asked to enter a prefix name, this will be each individual video's name prefix so after they get the audio removed, they can be concatenated into a single file
  ```bash
  Enter the final file name prefix: icd
  ```
2. The file prefix will be added to the filelist.txt including a number up to the total of videos found in the folder
  ```txt
  file 'icd_1.mp4'
  file 'icd_2.mp4'
  file 'icd_3.mp4'
  file 'icd_4.mp4'
  file 'icd_5.mp4'
  file 'icd_6.mp4'
  file 'icd_7.mp4'
  ```
3. You will be asked to enter a final concatenated file name, this should include the ending format too
  ```bash
  Enter the final concatenated file name (e.g., final_output.mp4): 2024_09_12.mp4
  ```
4. Depending on the number of videos, this might take hours/days to complete. The script will accelerate the videos to reduce their length. Then it will remove the audio and it will be cleaning up after processing all the files
 ```bash

Deleting icd_1.mp4
Deleting icd_2.mp4
Deleting icd_3.mp4
Deleting icd_4.mp4
Deleting icd_5.mp4
Deleting icd_6.mp4
Deleting icd_7.mp4

Finished

```
5. At the end, the folder should contain only the video_edit.sh script, the final concatenated file and the filelist.txt should be empty
![image](https://github.com/user-attachments/assets/076bb6e7-dc3d-4ef2-9cea-1095f5ae8972)








:duck:
