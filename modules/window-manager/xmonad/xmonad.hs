-- Base
import XMonad
import System.Directory
import System.IO (hClose, hPutStr, hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

  -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

  -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

  -- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory

  -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

  -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

 -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook, javaHack, trayerAboveXmobarEventHook, trayAbovePanelEventHook, trayerPaddingXmobarEventHook, trayPaddingXmobarEventHook, trayPaddingEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor

 -- ColorScheme module (SET ONLY ONE!)
    -- Possible choice are:
    -- DoomOne
    -- Dracula
    -- GruvboxDark
    -- MonokaiPro
    -- Nord
    -- OceanicNext
    -- Palenight
    -- SolarizedDark
    -- SolarizedLight
    -- TomorrowNight
-- import Colors.DoomOne


-- colorScheme = "doom-one"

colorBack = "#0c0c0c" -- "#000000"
colorFore = "#5f0087" -- "#bbc2cf"

-- color00 = "#0c0c0c"
-- color01 = "#897373" -- "#1c1f24"
-- color02 = "#CF7A6C" -- "#ff6c6b"
-- color03 = "#657689" -- "#98be65"
-- color04 = "#90848F" -- "#da8548"
-- color05 = "#A99299" -- "#51afef"
-- color06 = "#CFB1AC" -- "#c678dd"
-- color07 = "#e9dad4" -- "#5699af"
-- color08 = "#a39894" -- "#202328"
-- color09 = "#897373" -- "#5b6268"
-- color10 = "#CF7A6C" -- "#da8548"
-- color11 = "#CF7A6C" -- "#4db5bd"
-- color12 = "#90848F" -- "#ecbe7b"
-- color13 = "#A99299" -- "#3071db"
-- color14 = "#CFB1AC" -- "#a9a1e1"
-- color15 = "#e9dad4" -- "#d80933"
-- color16 = "#dfdfdf"

-- Special
background = "#010104"
foreground = "#c0aff1"
cursor = "#c0aff1"

-- Colors
color00 = "#010104"
color01 = "#552299"
color02 = "#5724A4"
color03 = "#6C4CBA"
color04 = "#5F2CC1"
color05 = "#6735CA"
color06 = "#7652CD"
color07 = "#c0aff1"
color08 = "#867aa8"
color09 = "#552299"
color10 = "#5724A4"
color11 = "#6C4CBA"
color12 = "#5F2CC1"
color13 = "#6735CA"
color14 = "#7652CD"
color15 = "#c0aff1"
color16 = "#c0aff1"


colorTrayer :: String
colorTrayer = "--tint 0x282c34"

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"
-- myFont = "Terminus style=Regular:size=9"
myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "kitty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser "  -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
-- myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor
myEditor = myTerminal ++ " -e nvim "    -- Sets vim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String       -- Border color of normal windows
myNormColor   = "#8edf5f" -- "#51bcfe" -- "#af00ff" -- "#552299" -- colorBack   -- This variable is imported from Colors.THEME

myFocusColor :: String      -- Border color of focused windows
myFocusColor  = "#8edf5f" -- "#af00ff"     -- This variable is imported from Colors.THEME

mySoundPlayer :: String
mySoundPlayer = "ffplay -nodisp -autoexit " -- The program that will play system sounds

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
  spawnOnce (mySoundPlayer ++ startupSound)
  -- spawn "killall conky"                    -- kill current conky on each restart
  -- spawn "killall xmobar" -- adding this in case of switching between xmobar and polybar.
  -- spawn "killall trayer" -- adding this in case of switching between xmobar and polybar.
  spawnOnce "lxsession"
  spawnOnce "picom -c --shadow-exclude 'class_g = \"Polybar\"' --shadow-exclude 'class_g = \"VirtualBoxVM\"' --backend glx --corner-radius 10"
  -- spawnOnce "xborders"
  spawnOnce "dunst"
  spawnOnce "nm-applet"
  spawnOnce "volumeicon"
  spawnOnce "notify-log $HOME/.log/notify.log"
  -- spawn "emacs --daemon" -- emacs daemon for the emacsclient
  spawn "polybar -c /etc/nixos/modules/toolbars/polybar/space/config.ini top"
  -- spawn "/etc/nixos/modules/toolbars/polybar/launch.sh --hack"
  spawnOnce "nitrogen --restore &"   -- if you prefer nitrogen to feh
  -- spawnOnce "unclutter -idle 1 &"
  spawnOnce "xrdb -merge ~/.Xresources"
  spawnOnce "xsetroot -cursor_name left_ptr"
  -- spawnOnce myTerminal ++ " -T weechat -e weechat"
  -- We killed any running conky processes earlier in the autostart,
  -- so now we sleep for 2 seconds and then restart conky.
  -- spawn "polybar --config=/etc/polybar/hack/config.ini top"
-- spawnOnce "sleep 2 && xmonad --restart"
  -- spawn ("sleep 3 && conky -c $HOME/.config/conky/xmonad/" ++ colorScheme ++ "-01.conkyrc")
  -- Select only =ONE= of the following four ways to set the wallpaper.
  -- spawnOnce "xargs xwallpaper --stretch < ~/.cache/wall"
  -- spawnOnce "~/.fehbg &"  -- set last saved feh wallpaper
  -- spawnOnce "feh --randomize --bg-fill /usr/share/backgrounds/dtos-backgrounds/*"  -- feh set random wallpaper
  -- setDefaultCursor xC_pirate
  setWMName "LG3D"

myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
  where
    navKeyMap = M.fromList [
      ((0,xK_Escape), cancel)
     ,((0,xK_Return), select)
     ,((0,xK_slash) , substringSearch myNavigation)
     ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
     ,((0,xK_h)     , move (-1,0)  >> myNavigation)
     ,((0,xK_Right) , move (1,0)   >> myNavigation)
     ,((0,xK_l)     , move (1,0)   >> myNavigation)
     ,((0,xK_Down)  , move (0,1)   >> myNavigation)
     ,((0,xK_j)     , move (0,1)   >> myNavigation)
     ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
     ,((0,xK_k)     , move (0,-1)  >> myNavigation)
     ,((0,xK_y)     , move (-1,-1) >> myNavigation)
     ,((0,xK_i)     , move (1,-1)  >> myNavigation)
     ,((0,xK_n)     , move (-1,1)  >> myNavigation)
     ,((0,xK_m)     , move (1,-1)  >> myNavigation)
     ,((0,xK_space) , setPos (0,0) >> myNavigation)
     ]
    navDefaultHandler = const myNavigation

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
              (0x28,0x2c,0x34) -- lowest inactive bg
              (0x28,0x2c,0x34) -- highest inactive bg
              (0xc7,0x92,0xea) -- active bg
              (0xc0,0xa7,0x9a) -- inactive fg
              (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
  { gs_cellheight   = 40
  , gs_cellwidth    = 200
  , gs_cellpadding  = 6
  , gs_navigate    = myNavigation
  , gs_originFractX = 0.5
  , gs_originFractY = 0.5
  , gs_font         = myFont
  }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
  where conf = def
                 { gs_cellheight   = 40
                 , gs_cellwidth    = 180
                 , gs_cellpadding  = 6
                 , gs_originFractX = 0.5
                 , gs_originFractY = 0.5
                 , gs_font         = myFont
                 }

runSelectedAction' :: GSConfig (X ()) -> [(String, X ())] -> X ()
runSelectedAction' conf actions = do
  selectedActionM <- gridselect conf actions
  case selectedActionM of
      Just selectedAction -> selectedAction
      Nothing -> return ()

-- gsCategories =
--   [ ("Games",      spawnSelected' gsGames)
--   --, ("Education",   spawnSelected' gsEducation)
--   , ("Internet",   spawnSelected' gsInternet)
--   , ("Multimedia", spawnSelected' gsMultimedia)
--   , ("Office",     spawnSelected' gsOffice)
--   , ("Settings",   spawnSelected' gsSettings)
--   , ("System",     spawnSelected' gsSystem)
--   , ("Utilities",  spawnSelected' gsUtilities)
--   ]

gsCategories =
  [ ("Games",      "xdotool key super+alt+1")
  , ("Education",  "xdotool key super+alt+2")
  , ("Internet",   "xdotool key super+alt+3")
  , ("Multimedia", "xdotool key super+alt+4")
  , ("Office",     "xdotool key super+alt+5")
  , ("Settings",   "xdotool key super+alt+6")
  , ("System",     "xdotool key super+alt+7")
  , ("Utilities",  "xdotool key super+alt+8")
  ]

gsGames =
  [ ("0 A.D.", "0ad")
  , ("Battle For Wesnoth", "wesnoth")
  , ("OpenArena", "openarena")
  , ("Sauerbraten", "sauerbraten")
  , ("Steam", "steam")
  , ("Unvanquished", "unvanquished")
  , ("Xonotic", "xonotic-glx")
  ]

gsEducation =
  [ ("GCompris", "gcompris-qt")
  , ("Kstars", "kstars")
  , ("Minuet", "minuet")
  , ("Scratch", "scratch")
  ]

gsInternet =
  [ ("Brave", "brave")
  , ("Discord", "discord")
  , ("Element", "element-desktop")
  , ("Firefox", "firefox")
  , ("LBRY App", "lbry")
  , ("Mailspring", "mailspring")
  , ("Nextcloud", "nextcloud")
  , ("Qutebrowser", "qutebrowser")
  , ("Transmission", "transmission-gtk")
  , ("Zoom", "zoom")
  ]

gsMultimedia =
  [ ("Audacity", "audacity")
  , ("Blender", "blender")
  , ("Deadbeef", "deadbeef")
  , ("Kdenlive", "kdenlive")
  , ("OBS Studio", "obs")
  , ("VLC", "vlc")
  ]

gsOffice =
  [ ("Document Viewer", "evince")
  , ("LibreOffice", "libreoffice")
  , ("LO Base", "lobase")
  , ("LO Calc", "localc")
  , ("LO Draw", "lodraw")
  , ("LO Impress", "loimpress")
  , ("LO Math", "lomath")
  , ("LO Writer", "lowriter")
  ]

gsSettings =
  [ ("ARandR", "arandr")
  , ("ArchLinux Tweak Tool", "archlinux-tweak-tool")
  , ("Customize Look and Feel", "lxappearance")
  , ("Firewall Configuration", "sudo gufw")
  ]

gsSystem =
  [ ("Alacritty", "alacritty")
  , ("Bash", (myTerminal ++ " -e bash"))
  , ("Htop", (myTerminal ++ " -e htop"))
  , ("Fish", (myTerminal ++ " -e fish"))
  , ("PCManFM", "pcmanfm")
  , ("VirtualBox", "virtualbox")
  , ("Virt-Manager", "virt-manager")
  , ("Zsh", (myTerminal ++ " -e zsh"))
  ]

gsUtilities =
  [ ("Emacs", "emacs")
  , ("Emacsclient", "emacsclient -c -a 'emacs'")
  , ("Nitrogen", "nitrogen")
  , ("Vim", (myTerminal ++ " -e vim"))
  ]

myScratchPads :: [NamedScratchpad]
myScratchPads =
  [ NS "terminal" spawnTerm findTerm manageTerm
  , NS "mocp" spawnMocp findMocp manageMocp
  , NS "calculator" spawnCalc findCalc manageCalc
  , NS "obsidian" spawnObsid findObsid manageObsid
  , NS "vencord" spawnVencord findVencord manageVencord
  , NS "code" spawnCode findCode manageCode
  , NS "discord" spawnDiscord findDiscord manageDiscord
  , NS "vlc" spawnVLC findVLC manageVLC
  , NS "okular" spawnOkular findOkular manageOkular
  , NS "virtualbox" spawnVirtualbox findVirtualbox manageVirtualbox
  , NS "keepassxc" spawnKeepass findKeepass manageKeepass
  , NS "drawio" spawnDrawio findDrawio manageDrawio
  , NS "slack" spawnSlack findSlack manageSlack
  , NS "thunderbird" spawnMail findMail manageMail
  , NS "pavucontrol" spawnPavu findPavu managePavu
  , NS "weechat" spawnWeechat findWeechat manageWeechat
  ]
  where
    --spawnTerm  = myTerminal ++ " --t scratchpad"
    --spawnTerm = "terminator -t scratchpad"
    spawnTerm = myTerminal ++ " --title alacritty-scratchpad"
    findTerm   = title =? "alacritty-scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnWeechat = myTerminal ++ " --title weechat -e weechat"
    findWeechat  = title =? "weechat"
    manageWeechat = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnObsid   = "obsidian"
    findObsid    = className =? "obsidian"
    manageObsid  = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnVencord  = "vesktop"
    findVencord   = className =? "vesktop"
    manageVencord = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnMail = "thunderbird"
    findMail = className =? "thunderbird"
    manageMail = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnPavu = "pavucontrol"
    findPavu = className =? "Pavucontrol"
    managePavu = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnDrawio = "drawio"
    findDrawio = className =? "draw.io"
    manageDrawio = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnSlack = "slack"
    findSlack = className =? "Slack"
    manageSlack = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnCode  = "code"
    findCode   = className =? "Code"
    manageCode = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnMocp  = myTerminal ++ " -T mocp -e mocp"
    findMocp   = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnDiscord  = "discord"
    findDiscord   = className =? "discord"
    manageDiscord = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnVLC = "vlc"
    findVLC = className =? "vlc"
    manageVLC = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnOkular = "okular"
    findOkular = className =? "okular"
    manageOkular = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnKeepass = "keepassxc"
    findKeepass = className =? "keepassxc"
    manageKeepass = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 -h
        l = 0.95 -w
    spawnVirtualbox = "VirtualBox"
    findVirtualbox = className =? "VirtualBox Manager"
    manageVirtualbox = customFloating $ W.RationalRect l t w h
      where
        h = 0.5
        w = 0.4
        t = 0.75 -h
        l = 0.70 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
      where
        h = 0.5
        w = 0.4
        t = 0.75 -h
        l = 0.70 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
         $ limitWindows 5
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         $ mySpacing 4
         $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         $ Full
floats   = renamed [Replace "floats"]
         $ smartBorders
         $ simplestFloat
grid     = renamed [Replace "grid"]
         $ limitWindows 9
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         $ mySpacing 4
         $ mkToggle (single MIRROR)
         $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
         $ limitWindows 9
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         $ mySpacing 4
         $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
         $ limitWindows 7
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
         $ limitWindows 7
         $ smartBorders
         $ windowNavigation
         $ addTabs shrinkText myTabTheme
         $ subLayout [] (smartBorders Simplest)
         -- Mirror takes a layout and rotates it by 90 degrees.
         -- So we are applying Mirror to the ThreeCol layout.
         $ Mirror
         $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
         -- I cannot add spacing to this layout because it will
         -- add spacing between window and tabs which looks bad.
         $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
         $ Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
         $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
               , activeColor         = color15
               , inactiveColor       = color08
               , activeBorderColor   = color15
               , inactiveBorderColor = colorBack
               , activeTextColor     = colorBack
               , inactiveTextColor   = color16
               }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
  { swn_font              = "xft:Ubuntu:bold:size=60"
  , swn_fade              = 1.0
  , swn_bgcolor           = "#1c1f24"
  , swn_color             = "#ffffff"
  }

-- The layout hook
myLayoutHook = avoidStruts
             $ mouseResize
             $ windowArrange
             $ T.toggleLayouts floats
             $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = withBorder myBorderWidth tall
                                           ||| noBorders monocle
                                           ||| floats
                                           ||| noBorders tabs
                                           ||| grid
                                           ||| spirals
                                           ||| threeCol
                                           ||| threeRow
                                           ||| tallAccordion
                                           ||| wideAccordion

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaces = ["Development", "CTF", "Web Browser", "Analysis", "Social", "Music", "Games", "VPN", "Notes"]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
-- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
-- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
-- I'm doing it this way because otherwise I would have to write out the full
-- name of my workspaces and the names would be very long if using clickable workspaces.
  [ className =? "confirm"         --> doFloat
  , className =? "file_progress"   --> doFloat
  , className =? "dialog"          --> doFloat
  , className =? "download"        --> doFloat
  , className =? "error"           --> doFloat
  , className =? "Gimp"            --> doFloat
  , className =? "notification"    --> doFloat
  , className =? "pinentry-gtk-2"  --> doFloat
  , className =? "splash"          --> doFloat
  , className =? "toolbar"         --> doFloat
  , className =? "remmina"         --> doShift "VPN"
  , className =? "Spotify"         --> doShift "Music"
  , className =? "Binary Ninja"    --> doShift "Analysis"
  , className =? "ghidra-Ghidra"   --> doFloat
  , className =? "steam_app_12200" --> doFloat
  -- , className =? "discord"         --> doCenterFloat
  -- , className =? "qutebrowser"     --> doShift "Web Browser"
  , className =? "Yad"             --> doCenterFloat
  -- , title =? "Oracle VM VirtualBox Manager"   --> doFloat
  , title =? "Order Chain - Market Snapshots" --> doFloat
  , title =? "emacs-run-launcher" --> doFloat
  , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
  , className =? "Brave-browser"   --> doShift ( myWorkspaces !! 1 )
  , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
  , className =? "Gimp"            --> doShift ( myWorkspaces !! 8 )
  -- , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
  , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
  , isFullscreen -->  doFullFloat
  ] <+> namedScratchpadManageHook myScratchPads

soundDir = "/etc/nixos/sounds/" -- The directory that has the sound files

startupSound  = soundDir ++ "startup-04.mp3"
shutdownSound = soundDir ++ "shutdown-03.mp3"
dmenuSound    = soundDir ++ "menu-02.mp3"

subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                    $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"SauceCodePro Nerd Font Mono 12\" --fore=#46d9ff back=#282c36 --center --geometry=1200x800 --title \"XMonad keybindings\""
  --hPutStr h (unlines $ showKm x) -- showKM adds ">>" before subtitles
  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
--(subtitle "Custom Keys":) $ mkNamedKeymap c $
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
    subKeys "Xmonad Essentials"
    [ ("M-C-r", addName "Recompile XMonad"       $ spawn "xmonad --recompile")
    , ("M-S-r", addName "Restart XMonad"         $ restart "xmonad" True)-- spawn "xmonad --restart")
    --, ("M-S-q", addName "Quit XMonad"            $ sequence_ [spawn (mySoundPlayer ++ shutdownSound), spawn "dm-logout"])
    , ("M-S-q", addName "Quit XMonad"            $ spawn "dm-logout")
    , ("M-S-c", addName "Kill focused window"    $ kill1)
    , ("M-S-a", addName "Kill all windows on WS" $ killAll)
    , ("M-S-<Return>", addName "Run prompt"      $ sequence_ [spawn (mySoundPlayer ++ dmenuSound), spawn "dmenu_run -nb '#000000' -sf '#eeeeee' -sb '#552299' -nf '#ffffff'"])
    , ("M-S-b", addName "Toggle bar show/hide"   $ sendMessage ToggleStruts)]

    ^++^ subKeys "Switch to workspace"
    [ ("M-1", addName "Switch to workspace 1"    $ (windows $ W.greedyView $ myWorkspaces !! 0))
    , ("M-2", addName "Switch to workspace 2"    $ (windows $ W.greedyView $ myWorkspaces !! 1))
    , ("M-3", addName "Switch to workspace 3"    $ (windows $ W.greedyView $ myWorkspaces !! 2))
    , ("M-4", addName "Switch to workspace 4"    $ (windows $ W.greedyView $ myWorkspaces !! 3))
    , ("M-5", addName "Switch to workspace 5"    $ (windows $ W.greedyView $ myWorkspaces !! 4))
    , ("M-6", addName "Switch to workspace 6"    $ (windows $ W.greedyView $ myWorkspaces !! 5))
    , ("M-7", addName "Switch to workspace 7"    $ (windows $ W.greedyView $ myWorkspaces !! 6))
    , ("M-8", addName "Switch to workspace 8"    $ (windows $ W.greedyView $ myWorkspaces !! 7))
    , ("M-9", addName "Switch to workspace 9"    $ (windows $ W.greedyView $ myWorkspaces !! 8))]

    ^++^ subKeys "Send window to workspace"
    [ ("M-S-1", addName "Send to workspace 1"    $ (windows $ W.shift $ myWorkspaces !! 0))
    , ("M-S-2", addName "Send to workspace 2"    $ (windows $ W.shift $ myWorkspaces !! 1))
    , ("M-S-3", addName "Send to workspace 3"    $ (windows $ W.shift $ myWorkspaces !! 2))
    , ("M-S-4", addName "Send to workspace 4"    $ (windows $ W.shift $ myWorkspaces !! 3))
    , ("M-S-5", addName "Send to workspace 5"    $ (windows $ W.shift $ myWorkspaces !! 4))
    , ("M-S-6", addName "Send to workspace 6"    $ (windows $ W.shift $ myWorkspaces !! 5))
    , ("M-S-7", addName "Send to workspace 7"    $ (windows $ W.shift $ myWorkspaces !! 6))
    , ("M-S-8", addName "Send to workspace 8"    $ (windows $ W.shift $ myWorkspaces !! 7))
    , ("M-S-9", addName "Send to workspace 9"    $ (windows $ W.shift $ myWorkspaces !! 8))]

    ^++^ subKeys "Move window to WS and go there"
    [ ("M-S-<Page_Up>", addName "Move window to next WS"   $ shiftTo Next nonNSP >> moveTo Next nonNSP)
    , ("M-S-<Page_Down>", addName "Move window to prev WS" $ shiftTo Prev nonNSP >> moveTo Prev nonNSP)]

    ^++^ subKeys "Window navigation"
    [ ("M-j", addName "Move focus to next window"                $ windows W.focusDown)
    , ("M-k", addName "Move focus to prev window"                $ windows W.focusUp)
    , ("M-m", addName "Move focus to master window"              $ windows W.focusMaster)
    , ("M-S-j", addName "Swap focused window with next window"   $ windows W.swapDown)
    , ("M-S-k", addName "Swap focused window with prev window"   $ windows W.swapUp)
    , ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster)
    , ("M-<Backspace>", addName "Move focused window to master"  $ promote)
    , ("M-S-,", addName "Rotate all windows except master"       $ rotSlavesDown)
    , ("M-S-.", addName "Rotate all windows current stack"       $ rotAllDown)]

    -- Dmenu scripts (dmscripts)
    -- In Xmonad and many tiling window managers, M-p is the default keybinding to
    -- launch dmenu_run, so I've decided to use M-p plus KEY for these dmenu scripts.
    ^++^ subKeys "Dmenu scripts"
    [ ("M-p h", addName "List all dmscripts"     $ spawn "dm-hub")
    , ("M-p a", addName "Choose ambient sound"   $ spawn "dm-sounds")
    , ("M-p b", addName "Set background"         $ spawn "dm-setbg")
    , ("M-p c", addName "Choose color scheme"    $ spawn "~/.local/bin/dtos-colorscheme")
    , ("M-p C", addName "Pick color from scheme" $ spawn "dm-colpick")
    , ("M-p e", addName "Edit config files"      $ spawn "dm-confedit")
    , ("M-p i", addName "Take a screenshot"      $ spawn "dm-maim")
    , ("M-p k", addName "Kill processes"         $ spawn "dm-kill")
    , ("M-p m", addName "View manpages"          $ spawn "dm-man")
    , ("M-p n", addName "Store and copy notes"   $ spawn "dm-note")
    , ("M-p o", addName "Browser bookmarks"      $ spawn "dm-bookman")
    , ("M-p p", addName "Passmenu"               $ spawn "passmenu -p \"Pass: \"")
    , ("M-p q", addName "Logout Menu"            $ spawn "dm-logout")
    , ("M-p r", addName "Listen to online radio" $ spawn "dm-radio")
    , ("M-p s", addName "Search various engines" $ spawn "dm-websearch")
    , ("M-p t", addName "Translate text"         $ spawn "dm-translate")]

    ^++^ subKeys "Favorite programs"
    [ ("M-<Return>", addName "Launch terminal"   $ spawn (myTerminal))
    , ("M-b", addName "Launch web browser"       $ spawn (myBrowser))
    , ("M-M1-h", addName "Launch htop"           $ spawn (myTerminal ++ " -e htop"))]

    ^++^ subKeys "Monitors"
    [ ("M-.", addName "Switch focus to next monitor" $ nextScreen)
    , ("M-,", addName "Switch focus to prev monitor" $ prevScreen)]

    -- Switch layouts
    ^++^ subKeys "Switch layouts"
    [ ("M-<Tab>", addName "Switch to next layout"   $ sendMessage NextLayout)
    , ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)]

    -- Window resizing
    ^++^ subKeys "Window resizing"
    [ ("M-h", addName "Shrink window"               $ sendMessage Shrink)
    , ("M-l", addName "Expand window"               $ sendMessage Expand)
    , ("M-M1-j", addName "Shrink window vertically" $ sendMessage MirrorShrink)
    , ("M-M1-k", addName "Expand window vertically" $ sendMessage MirrorExpand)]

    -- Floating windows
    ^++^ subKeys "Floating windows"
    [ ("M-f", addName "Toggle float layout"        $ sendMessage (T.Toggle "floats"))
    , ("M-t", addName "Sink a floating window"     $ withFocused $ windows . W.sink)
    , ("M-S-t", addName "Sink all floated windows" $ sinkAll)]

    -- Increase/decrease spacing (gaps)
    ^++^ subKeys "Window spacing (gaps)"
    [ ("C-M1-j", addName "Decrease window spacing" $ decWindowSpacing 4)
    , ("C-M1-k", addName "Increase window spacing" $ incWindowSpacing 4)
    , ("C-M1-h", addName "Decrease screen spacing" $ decScreenSpacing 4)
    , ("C-M1-l", addName "Increase screen spacing" $ incScreenSpacing 4)]

    -- Increase/decrease windows in the master pane or the stack
    ^++^ subKeys "Increase/decrease windows in master pane or the stack"
    [ ("M-S-<Up>", addName "Increase clients in master pane"   $ sendMessage (IncMasterN 1))
    , ("M-S-<Down>", addName "Decrease clients in master pane" $ sendMessage (IncMasterN (-1)))
    , ("M-=", addName "Increase max # of windows for layout"   $ increaseLimit)
    , ("M--", addName "Decrease max # of windows for layout"   $ decreaseLimit)]

    -- Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
    ^++^ subKeys "Sublayouts"
    [ ("M-C-h", addName "pullGroup L"           $ sendMessage $ pullGroup L)
    , ("M-C-l", addName "pullGroup R"           $ sendMessage $ pullGroup R)
    , ("M-C-k", addName "pullGroup U"           $ sendMessage $ pullGroup U)
    , ("M-C-j", addName "pullGroup D"           $ sendMessage $ pullGroup D)
    , ("M-C-m", addName "MergeAll"              $ withFocused (sendMessage . MergeAll))
    -- , ("M-C-u", addName "UnMerge"               $ withFocused (sendMessage . UnMerge))
    , ("M-C-/", addName "UnMergeAll"            $  withFocused (sendMessage . UnMergeAll))
    , ("M-C-.", addName "Switch focus next tab" $  onGroup W.focusUp')
    , ("M-C-,", addName "Switch focus prev tab" $  onGroup W.focusDown')]

    -- Scratchpads
    -- Toggle show/hide these programs. They run on a hidden workspace.
    -- When you toggle them to show, it brings them to current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
    ^++^ subKeys "Scratchpads"
    [ ("M-s t", addName "Toggle scratchpad terminal"   $ namedScratchpadAction myScratchPads "terminal")
    , ("M-s w", addName "Toggle weechat terminal"      $ namedScratchpadAction myScratchPads "weechat")
    , ("M-s m", addName "Toggle scratchpad mocp"       $ namedScratchpadAction myScratchPads "mocp")
    , ("M-s o", addName "Toggle scratchpad obsidian"   $ namedScratchpadAction myScratchPads "obsidian")
    , ("M-s e", addName "Toggle scratchpad thunderbird" $ namedScratchpadAction myScratchPads "thunderbird")
    , ("M-s x", addName "Toggle scratchpad code"   $ namedScratchpadAction myScratchPads "code")
    , ("M-s f", addName "Toggle scratchpad slack"    $ namedScratchpadAction myScratchPads "slack")
    , ("M-s d", addName "Toggle scratchpad vencord" $ namedScratchpadAction myScratchPads "discord")
    , ("M-s k", addName "Toggle scratchpad vlc"    $ namedScratchpadAction myScratchPads "vlc")
    , ("M-s v", addName "Toggle scratchpad virtualbox"    $ namedScratchpadAction myScratchPads "virtualbox")
    , ("M-s s", addName "Toggle scratchpad keepassxc"    $ namedScratchpadAction myScratchPads "keepassxc")
    , ("M-s p", addName "Toggle scratchpad okular"    $ namedScratchpadAction myScratchPads "okular")
    , ("M-d",   addName "Toggle scratchpad draw.io" $ namedScratchpadAction myScratchPads "drawio")
    , ("M-p", addName "Toggle scratchpad pavucontrol" $ namedScratchpadAction myScratchPads "pavucontrol")
    , ("M-<Escape>", addName "Toggle scratchpad calculator" $ namedScratchpadAction myScratchPads "calculator")]

    -- Controls for mocp music player (SUPER-u followed by a key)
    ^++^ subKeys "Mocp music player"
    [ ("M-u p", addName "mocp play"                $ spawn "mocp --play")
    , ("M-u l", addName "mocp next"                $ spawn "mocp --next")
    , ("M-u h", addName "mocp prev"                $ spawn "mocp --previous")
    , ("M-u <Space>", addName "mocp toggle pause"  $ spawn "mocp --toggle-pause")]

    ^++^ subKeys "GridSelect"
    -- , ("C-g g", addName "Select favorite apps"     $ runSelectedAction' defaultGSConfig gsCategories)
    [ ("M-M1-<Return>", addName "Select favorite apps" $ spawnSelected'
         $ gsGames ++ gsEducation ++ gsInternet ++ gsMultimedia ++ gsOffice ++ gsSettings ++ gsSystem ++ gsUtilities)
    , ("M-M1-c", addName "Select favorite apps"    $ spawnSelected' gsCategories)
    , ("M-M1-t", addName "Goto selected window"    $ goToSelected $ mygridConfig myColorizer)
    , ("M-M1-b", addName "Bring selected window"   $ bringSelected $ mygridConfig myColorizer)
    , ("M-M1-1", addName "Menu of games"           $ spawnSelected' gsGames)
    , ("M-M1-2", addName "Menu of education apps"  $ spawnSelected' gsEducation)
    , ("M-M1-3", addName "Menu of Internet apps"   $ spawnSelected' gsInternet)
    , ("M-M1-4", addName "Menu of multimedia apps" $ spawnSelected' gsMultimedia)
    , ("M-M1-5", addName "Menu of office apps"     $ spawnSelected' gsOffice)
    , ("M-M1-6", addName "Menu of settings apps"   $ spawnSelected' gsSettings)
    , ("M-M1-7", addName "Menu of system apps"     $ spawnSelected' gsSystem)
    , ("M-M1-8", addName "Menu of utilities apps"  $ spawnSelected' gsUtilities)]

    -- Emacs (SUPER-e followed by a key)
    ^++^ subKeys "Emacs"
    [("M-e e", addName "Emacsclient"               $ spawn (myEmacs))
    -- ("M-e e", addName "Emacsclient Dashboard"    $ spawn (myEmacs ++ ("--eval '(dashboard-refresh-buffer)'")))
    , ("M-e a", addName "Emacsclient EMMS (music)" $ spawn (myEmacs ++ ("--eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/\")'")))
    , ("M-e b", addName "Emacsclient Ibuffer"      $ spawn (myEmacs ++ ("--eval '(ibuffer)'")))
    , ("M-e d", addName "Emacsclient Dired"        $ spawn (myEmacs ++ ("--eval '(dired nil)'")))
    , ("M-e i", addName "Emacsclient ERC (IRC)"    $ spawn (myEmacs ++ ("--eval '(erc)'")))
    , ("M-e n", addName "Emacsclient Elfeed (RSS)" $ spawn (myEmacs ++ ("--eval '(elfeed)'")))
    , ("M-e s", addName "Emacsclient Eshell"       $ spawn (myEmacs ++ ("--eval '(eshell)'")))
    --, ("M-e v", addName "Emacsclient Vterm"        $ spawn (myEmacs ++ ("--eval '(+vterm/here nil)'")))
    , ("M-e v", addName "Emacsclient Vterm"        $ spawn (myEmacs ++ ("--eval '(vterm)'")))
    , ("M-e w", addName "Emacsclient EWW Browser"  $ spawn (myEmacs ++ ("--eval '(doom/window-maximize-buffer(eww \"distro.tube\"))'")))]

    -- Multimedia Keys
    ^++^ subKeys "Multimedia keys"
    [ ("<XF86AudioPlay>", addName "mocp play"           $ spawn "mocp --play")
    , ("<XF86AudioPrev>", addName "mocp next"           $ spawn "mocp --previous")
    , ("<XF86AudioNext>", addName "mocp prev"           $ spawn "mocp --next")
    , ("<XF86AudioMute>", addName "Toggle audio mute"   $ spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", addName "Lower vol"    $ spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>", addName "Raise vol"    $ spawn "amixer set Master 5%+ unmute")
    , ("<XF86HomePage>", addName "Open home page"       $ spawn (myBrowser ++ " https://blog.i-eat-sponges.com"))
    , ("<XF86Search>", addName "Web search (dmscripts)" $ spawn "dm-websearch")
    , ("<XF86Mail>", addName "Email client"             $ runOrRaise "thunderbird" (resource =? "thunderbird"))
    , ("<XF86Calculator>", addName "Calculator"         $ runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk"))
    , ("<XF86Eject>", addName "Eject /dev/cdrom"        $ spawn "eject /dev/cdrom")
    , ("<Print>", addName "Take screenshot (dmscripts)" $ spawn "flameshot gui")
    ]
    -- The following lines are needed for named scratchpads.
    where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
          nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

main :: IO ()
main = do
  --  , layoutHook         = myLayoutHook -- showWName' myShowWNameTheme $ myLayoutHook
  -- the xmonad, ya know...what the WM is named after!
  xmonad $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $ docks . ewmh $ def
    { manageHook         = myManageHook <+> manageDocks
    , handleEventHook    = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty"  <||> className =? "st-256color" <||> className =? "XTerm") (return True) <> trayerPaddingXmobarEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    }
