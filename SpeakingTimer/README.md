# iOS_Speaking_Timer

## REQUIREMENTS
Develop a timer-like app for iPhone and Apple Watch where I can select time interval in hours and minutes.

The starting, stopping and resetting of timer should be similar to iOS timer app.

The difference, the app should say (AVFramework) the following if a specific countdown value is reached:

- if more than one hour at each full hour say: "still n hours left"
- if exactly one hour say: "still one hour left"
- if less than one hour and more than ten minutes each ten minutes say: "still n minutes left" (50,40,30,20,10)
- if 5 minutes left say: "still 5 minutes left"
- if less then 5 minutes each minute say: "still n minutes left" (4,3,2,1)
- if equals or less than 1 minute each 10 seconds say: "still n seconds left" (60,50,40,30,20,10)
- if less than 10 seconds left countdown each second: "9", "8" ... "1"
- if timer finishes say: "time is over"

All GUI texts and the spoken text must be localized by iOS string localization.
The GUI must be easy to understand and use.
Easy interval selection and easy start/stop/reset.
The Timer must also run in background, if the user locks the device during a running timer.



## IMPLEMENTATION
Following the job's requirements, I have developed a Speaking Timer app for iPhone and Apple Watch using the latest Xcode and Swift. Where users can set up a timer through a friendly interface. The timer has options to Start, Stop, Pause and Resume. It also speaks loudly the time left on the timer following the client’s requirements. And when the timer is over the alarm shows up with its alarm’s sound.

The app runs also in the background, keeping the timer and voice work.

All the texts and the spoken text are localized. I have added English and German as an example.

All the code is well documented, including Unit test, UI Tests, and Manual test. The project’s code follows Clean Code protocols and MVVM architecture.

The design follows Apple’s GUI. It is clean, functional and well-presented.

###### Develop by KoBinary.
