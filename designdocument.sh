#Currently described arguments:
--add -a
--all -A
--create -c
--duplicate -D
--focus -F
--from -f
--list-stacks -L
--move -m
--new-stack -n
--new-stack-auto -N
--remove -r
--select -S
--stack -s
--to -t

#List all stacks
pupu --list-stacks
#> doc
#> misc

#Add existing firefox window to currently selected stack
pupu -a firefox

#Add existing firefox and vim windows to currently selected stack
pupu -a firefox vim

#Create and add new firefox and vim windows to currently selected stack
pupu -ca firefox vim

#Create and add new firefox and vim windows to currently selected stack, then focus it
pupu -ca firefox vim -F

#Create and add new windows firefox and vim to New and automatically named stack, then focus it
pupu -ca firefox vim -NF

#Focusing the currently selected stack on screens
pupu -F

#Add emacs to stack doc (creating it if needed)
pupu -a emacs --stack doc
#or
pupu -a emacs -s doc

#Creating a new stack
pupu -n doc

#Remove firefox and vim from stack "doc"
pupu -s doc -r firefox
pupu -r vim
#In one go:
pupu -s doc -r firefox vim

#Remove everything from stack "doc"
pupu -r --all --stack doc
#...or
pupu -r -A -s doc
#...or
pupu -rAs doc
#...or
pupu -Ars doc

#Move firefox from --stack doc --to misc
pupu -m firefox -s doc -t misc
#...same as
pupu -s doc -r firefox
pupu -s misc -a firefox
#Also, if doc is active we only need to do
pupu -m firefox -t misc

#Move everything on the doc stack to the misc stack
pupu -mA -s doc -t misc
#--from is the same as --stack:
pupu -mA -f doc -t misc

#Add everything in the doc stack to the misc stack (--duplicate --all --from doc --to misc)
pupu -DA -f doc -t misc

#Add firefox to stacks doc and misc
pupu -a firefox -s doc misc
#...same as
pupu -a firefox -t doc misc

#Can't add from a stack
pupu -a firefox -f doc #syntax error!

#Delete stack "doc"
pupu -d doc

#Shortcuts
#Given selected stack main = [firefox]:
pupu -m firefox -n browsers
#...same as
pupu -n browsers
pupu -m firefox -t browsers
#...same as
pupu -n browsers
pupu -S browsers
pupu -m firefox -f main

#-F to Focus after operation
pupu -a firefox
pupu -F
#...same as
pupu -a firefox -F
#TBA: Focus what? The --to stack?

#-S to Select after operation
pupu -a firefox -t browsers -S
#...same as
pupu -a firefox -t browsers
pupu -S browsers


########################################################
#Example, implementation of example at
#https://www.reddit.com/r/linuxquestions/comments/4lv2ph/good_automatic_tiling_window_manager/
pupu unfocus #Nothing is now shown on screen
pupu -a xterm -s master #Selects stack master is optional
pupu -F #Focuses windows, e.g. shows them to the screens
#[Xterm, Empty]

pupu -a eog* -F
#[Xterm, 5 eog windows]

pupu -a firefox -F
#[Xterm|Firefox, 5 eog windows]

pupu -m xterm firefox -n new #Move xterm and firefox to new stack called `new`
pupu -S new
pupu -F #focus stack `new`
#[Xterm, Firefox]

pupu -r firefox #removes firefox from stack `new`
pupu -a eog* #adds five eog windows instead
pupu -F
#[Xterm, 5 eog windows]
#Alternative to last operation: --replace, --with
pupu -R firefox -t master -w eog*
#More explicit:
pupu -f new -t master -R firefox -w eog* #"From stack new to stack master, replace firefox with eog*"

###########################################################
#Version with less manual stack handling:
pupu -a xterm -n AUTO -SF #[Xterm, Empty]
pupu -a eog* -F #[Xterm, 5 eog windows]
pupu -a firefox -F #[Xterm|Firefox, 5 eog windows]
pupu -m xterm firefox -n AUTO -SF #[Xterm, Firefox]
pupu -R firefox -w eog* -t PREV -F #[Xterm, 5 eog windows]


#Toggling between the two created stacks,
#e.g between [Xterm, 5 eog windows] and
pupu -Ss PREV -F #--Select --session PREV --Focus


#Possible keybinds
$mod-a exec pupu -a $FOCUSED #"add"
$mod-r exec pupu -r $FOCUSED #"remove"
$mod-A exec pupu -a $FOCUSED -F #"add and focus"
$mod-r exec pupu -r $FOCUSED #"remove"

$mod-c exec pupu -n AUTO #"clear"
$mod-f exec pupu -F

$mod-h exec focus-left
$mod-j exec focus-down
$mod-k exec focus-up
$mod-l exec focus-right

#"Add focused window, go right, add focused window, refocus" is now
$mod-alaf

#hidden: []
#screen: *xterm*,firefox,eog
#stack:  []
$mod-a
#hidden: []
#screen: *xterm*,firefox,eog
#stack:  [xterm]
$mod-l
#hidden: []
#screen: xterm,*firefox*,eog
#stack:  [xterm]
$mod-A
#hidden: [eog]
#screen: xterm,firefox
#stack:  [xterm, firefox]


#Pin xterm, move right, pin firefox, hide:
$mod-a, $mod-l, $mod-a, $mod-h
