# Madcow 2.0 - Editor Support

## Sublime Text 3

In order to have syntax highlighting for Madow 2 files (.grass) when using Sublime Text 3, you just need to follow the steps below:

* Copy the files below, located in this (./editor/sublime-text3) directory
    * grass.JSON-tmLanguage
    * grass.tmLanguage
* Place them in the following Sublime Text 3 directory:
    * Mac (/Users/<user name>/Library/Application Support/Sublime Text 3/Packages/User)
    * Windows (C:\Users\<user name>\AppData\Roaming\Sublime Text 3\Packages/User)
    * If the directories described above do not correspond to your setup then you can open the 'Preferences-Browse Packages' menu, and this will indicate (the directory above) where you need to copy these files.
    
Once you have done this, restart Sublime, and then your Madcow '.grass' files should now have syntax highlighting.