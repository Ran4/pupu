#List all stacks
pupu list
#> doc
#> misc

#Focusing all apps in the stack on screens
pupu focus

#Pushing firefox and vim to current stack
pupu push firefox vim
pupu focus

#Pushing emacs to stack doc (creating it if needed)
pupu push firefox --stack doc
#or
pupu push firefox -s doc

#Creating a new stack
pupu push -s doc

#Remove firefox and vim from stack "doc"
pupu pull -s doc firefox
pupu pull vim
#In one go:
pupu pull -s doc firefox vim

#Remove everything from stack "doc"
pupu pull --all --stack doc
#...or
pupu pull -a -s doc
#...or
pupu pull -as doc

#Move firefox from --stack doc --to misc
pupu move -s doc -t misc firefox
#...same as
pupu pull -s doc firefox
pupu push -s misc firefox
#Also, if doc is active we only need to do
pupu move -t misc firefox

#Move everything on the doc stack to the misc stack
pupu move -s doc -t misc -a
#--from is the same as --stack:
pupu move -f doc -t misc -a

#Add everything in the doc stack to the misc stack
pupu copy -s doc -t misc -a

#Push firefox to stacks doc and misc
pupu push firefox -s doc misc
#...same as
pupu push firefox -t doc misc

#Can't push from a stack
pupu push firefox -f doc #syntax error!

#Delete stack "doc"
pupu delete doc


#Shortcuts
#Given stack main = [firefox]:
pupu move firefox -n browsers
#...same as
pupu new browsers
pupu move firefox -t browsers
#...same as
pupu new browsers
pupu select browsers
pupu move firefox -f main

#-F to Focus after operation
pupu push firefox
pupu focus
#...same as
pupu push firefox -F
#TBA: Focus what? The --to stack?

#-S to Select after operation
pupu push firefox -t browsers -S
#...same as
pupu push firefox -t browsers
pupu select browsers

########################################################
#Example, implementation of example at
#https://www.reddit.com/r/linuxquestions/comments/4lv2ph/good_automatic_tiling_window_manager/
pupu unfocus #Nothing is now shown on screen
pupu push xterm -s master #Selects stack master is optional
pupu focus
#[Xterm, Empty]

pupu push eog*
pupu focus
#[Xterm, 5 eog windows]

pupu push firefox
pupu focus
#[Xterm|Firefox, 5 eog windows]

pupu move xterm firefox -n new #Move xterm and firefox to new stack called `new`
pupu select new
pupu focus #focus stack `new`
#[Xterm, Firefox]

pupu pull firefox #removes firefox from stack `new`
pupu push eog* #adds five eog windows instead
pupu focus
#[Xterm, 5 eog windows]
#Alternative to last operation:
pupu replace firefox -t master eog*
#More explicit:
pupu replace -f new firefox -t master eog*

###########################################################
#Version with less manual stack handling:
pupu push xterm -n AUTO -SF #[Xterm, Empty]
pupu push eog* -F #[Xterm, 5 eog windows]
pupu push firefox -F #[Xterm|Firefox, 5 eog windows]
pupu move xterm firefox -n AUTO -SF #[Xterm, Firefox]
pupu replace firefox -t PREV *eog -F #[Xterm, 5 eog windows]


#Toggling between the two created stacks,
#e.g between [Xterm, 5 eog windows] and
pupu focus -s PREV -S
#...same as
pupu focus PREV -S
#...same as
pupu select PREV -F
#...same as
pupu select PREV
pupu focus




#Possible keybinds
#"select then"
