# Removing comments from program
Tried thinking of a way to program a method to remove documentation for various kinds of languages-

Should I hard-code each condition for each language? **No.**

How about looking up an online database that already has this information? **Maybe.**

Perhaps I should reuse what's already on my local desktop? **Yes.**

#HowTo

Prerequisite:
* Notepad++ installed

This program requires you to have Notepad++ installed, as it parses through the langs.model.xml for instances. This allows me to find comments for any type of file extension and remove the comments specified in that language.

Run the program
`./commentRemover.ps1 file_name.ext`

[WIP]
