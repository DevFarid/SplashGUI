# SplashGUI
## Made by John Sundell, modified by Farid Kamizi.

## Purpose of the program.
Allows the user to format Swift syntax to HTML output.
ALlows the user to turn .md files into a .playground.

## Problems fixed by SplashGUI
Imagine you are writing an article for the Swift courses we offer, and you have to include programming expression and statements in your article.
The default carmen, format as code is a bit scuffed, and to be fair, not that visually appealing.

SplashGUI fixes that by taking a statement, expression, or a code block, and transforms it so your articles look neat!
SplashGUI also allows you to write psuedo code within your .md files.

## Example input of SplashHTML
![SplashGUI Showcase](https://i.imgur.com/bGFA1uf.png "SplashGUI Showcase")
As you can see, the left panel of the application is the INPUT section. And the right panel of the application is the output.
Go ahead and copy the right side of the panel.

Now goto your article's content editor
![Canvas Content Editor](https://i.imgur.com/qneW72z.png "Canvas Content Editor")
Press the `</>` where you can view the source code of the content editor.
Gracefully paste the HTML/CSS code, in your Canvas's HTML/CSS content editor as shown below in the image.

![Pasting the program's output onto the CSS/HTML editor of carmen](https://i.imgur.com/PnRxB3r.png "Pasting the program's output onto the CSS/HTML editor of carmen")

Again, press the `</>` to switch back to the regular text editor, and now you should see the visual changes.
![Results](https://i.imgur.com/gQc6S6y.png "Results")

## <psuedo> option for Digital Flagship's own playmaker
Inside of a `.MD` format it like this:
![Psuedo Code Formatting](https://i.imgur.com/IAjAbJd.png "Psuedo Code Formatting")

How it will look inside of a `.playground`
![Playground Formatting](https://i.imgur.com/vqJqikI.png "Playground Formatting")

## Image sequence of turning a directory of `.MD` into `.playground`
Follow the steps carefully.

Switch to the Playmaker tab.
![Playmaker Main Page](https://i.imgur.com/QQt86q3.png "Playmaker Main Page")

Press the red select folder button.
![File dialogue upon `Select Folder` Button Tap](https://i.imgur.com/0rac0R3.png "File dialogue upon `Select Folder` Button Tap")

Select the desired directory from the File dialogue pop-up option, and press `Open`
![Select the desired directory](https://i.imgur.com/0rac0R3.png "Select the desired directory")

Upon pressing `Done`, you should see the page change, and list information about the directory.
You should also see the individual `.MD` files that were found within that directory.
In addition, you should now see the `Playground it` button lit up, and enabled.
![Loaded .MD files](https://i.imgur.com/flUDu6c.png "Loaded .MD files")

Press the `playground it` button to create your `.playground` file. 
The information on the page will change again, and this time it will display `Output` for when its in writing mode.
![Output message](https://i.imgur.com/VIOyakU.png "Output message")

Now, if you visit the same directory, you should see a `.playground` file that has all your `.md` files within it.
![Produced playground file](https://i.imgur.com/ESf4xKW.png "Produced playground file")
