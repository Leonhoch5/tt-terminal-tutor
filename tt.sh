#!/bin/bash

# =============================================
# DISTRIBUTION DETECTION AND PACKAGE MANAGEMENT
# =============================================

# Detect package manager
function get_pkg_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Install yad appropriately for the distro
function install_yad() {
    PKG_MGR=$(get_pkg_manager)
    
    case $PKG_MGR in
        "apt")
            sudo apt-get update && sudo apt-get install -y yad || return 1
            ;;
        "dnf")
            sudo dnf install -y yad || return 1
            ;;
        "yum")
            sudo yum install -y epel-release
            sudo yum install -y yad || return 1
            ;;
        "pacman")
            sudo pacman -Sy --noconfirm yad || return 1
            ;;
        "zypper")
            sudo zypper install -y yad || return 1
            ;;
        *)
            echo "Unable to determine package manager. Please install yad manually:"
            echo "See https://github.com/v1cont/yad"
            return 1
            ;;
    esac
}

# Check for yad with installation prompt
function check_yad() {
    if ! command -v yad &> /dev/null; then
        yad --question --title="Install Required Package" \
            --text="YAD (GUI component) is not installed. Would you like to install it now?" \
            --button="Install:0" --button="Terminal Version:1"
        
        if [ $? -eq 0 ]; then
            install_yad || {
                yad --error --text="Failed to install YAD. Falling back to terminal version."
                sleep 2
                main_terminal
                exit
            }
        else
            main_terminal
            exit
        fi
    fi
}

# ======================
# GUI INTERFACE FUNCTIONS
# ======================

# Main GUI menu
function main_gui() {
    while true; do
        choice=$(yad --center --width=400 --height=300 --title "Terminal Tutor" \
            --list --radiolist --column "Select" --column "Option" \
            TRUE "Graphical Lessons" \
            FALSE "Terminal Version" \
            FALSE "Install System-Wide" \
            FALSE "Exit" \
            --button="Select:0" --button="Cancel:1")

        [ $? -ne 0 ] && exit 0

        selection=$(echo "$choice" | cut -d'|' -f2)

        case "$selection" in
            "Graphical Lessons") gui_lessons ;;
            "Terminal Version") main_terminal ;;
            "Install System-Wide") install_system_wide ;;
            "Exit") exit 0 ;;
            *) yad --error --text="Invalid selection" ;;
        esac
    done
}

# GUI Lessons browser
function gui_lessons() {
    while true; do
        lesson=$(yad --center --width=600 --height=500 --title "Terminal Tutor - Lessons" \
            --list --radiolist --column "Select" --column "Lesson" --column "Description" \
            FALSE "1" "What is the terminal? (Introduction)" \
            FALSE "2" "Understanding the Shell and Bash" \
            FALSE "3" "Basic Commands (Hands-on Practice)" \
            FALSE "4" "File System Navigation" \
            FALSE "5" "Working with Files and Directories" \
            FALSE "6" "Pipes & Redirection" \
            FALSE "7" "Variables & Simple Scripts" \
            FALSE "8" "Network Commands (curl, ping)" \
            FALSE "Terminal" "Switch to Terminal Version" \
            --button="Learn:0" --button="Back:1")

        [ $? -ne 0 ] && return

        lesson_num=$(echo "$lesson" | cut -d'|' -f2)

        case "$lesson_num" in
            "1") show_lesson "What is the Terminal?" "$(what_is_terminal_gui)" ;;
            "2") show_lesson "Understanding Shell and Bash" "$(what_is_shell_gui)" ;;
            "3") show_lesson "Basic Commands" "$(basic_commands_gui)" ;;
            "4") show_lesson "File Navigation" "$(navigation_gui)" ;;
            "5") show_lesson "Files & Directories" "$(files_dirs_gui)" ;;
            "6") show_lesson "Pipes & Redirection" "$(pipes_gui)" ;;
            "7") show_lesson "Variables & Scripts" "$(variables_gui)" ;;
            "8") show_lesson "Network Commands" "$(network_commands_gui)" ;;
            "Terminal") main_terminal ;;
            *) yad --error --text="Invalid lesson selection" ;;
        esac
    done
}

# Show lesson in GUI
function show_lesson() {
    title="$1"
    content="$2"
    
    yad --center --width=700 --height=500 --title "$title" \
        --text-info --wrap --filename=<(echo "$content") \
        --button="Try in Terminal:2" --button="Back:1"
    
    [ $? -eq 2 ] && main_terminal
}

# GUI Lesson Content
function what_is_terminal_gui() {
    echo "📘 <b>What is the Terminal?</b>
    
The terminal is a text-based interface to your computer. While modern systems have graphical interfaces, the terminal is powerful because:

<b>Advantages:</b>
• Faster for many tasks
• Can automate repetitive work
• Works over remote connections
• More control and options

<b>Try these commands later:</b>
• <tt>whoami</tt> - Shows your username
• <tt>date</tt> - Shows current date/time
• <tt>cal</tt> - Displays a calendar

<i>When you're ready, try the terminal version to practice!</i>"
}

function what_is_shell_gui() {
    echo "📘 <b>Understanding Shell and Bash</b>

A <b>shell</b> is a program that interprets your commands. <b>Bash</b> (Bourne Again Shell) is the most common shell.

<b>Key Features:</b>
• Command execution
• Tab completion (try pressing Tab)
• Command history (Up arrow)
• Scripting capabilities

<b>Try these in terminal:</b>
1. Type <tt>echo hello</tt> and press Enter
2. Press Up arrow to recall the command
3. Type <tt>ec</tt> and press Tab to autocomplete

<i>The prompt (usually ending with $) means the shell is ready.</i>"
}

function basic_commands_gui() {
    echo "📘 <b>Basic Commands</b>

<b>Essential Commands:</b>
1. <tt>pwd</tt> - Shows current folder
2. <tt>ls</tt> - Lists files:
   • <tt>ls</tt> - Basic listing
   • <tt>ls -l</tt> - Detailed view
3. <tt>cd</tt> - Change directory:
   • <tt>cd ~</tt> - Go home
   • <tt>cd ..</tt> - Go up one level

<i>Try these in the terminal version!</i>"
}

function network_commands_gui() {
    echo "📘 <b>Network Commands</b>

<b>Key Commands:</b>
1. <tt>ping</tt> - Check server connection:
   • <tt>ping -c 4 terminal-tutor.glitch.me</tt>
2. <tt>curl</tt> - Transfer data from URLs:
   • <tt>curl https://terminal-tutor.glitch.me</tt>
3. <tt>ifconfig</tt>/<tt>ip a</tt> - Show network info

<b>Our Terminal Tutor server:</b>
We'll automatically wake up the Glitch server when you try these commands in the terminal version.

<i>Note: Some commands need admin privileges (sudo).</i>"
}

# ========================
# TERMINAL MODE FUNCTIONS
# ========================

function main_terminal() {
    clear
    echo "============================================"
    echo "  🐧 Welcome to Terminal Tutor (Terminal)   "
    echo "============================================"
    echo "1) What is the terminal? (Introduction)"
    echo "2) Understanding the Shell and Bash"
    echo "3) Basic Commands (Hands-on Practice)"
    echo "4) File System Navigation (Step-by-Step)"
    echo "5) Working with Files and Directories"
    echo "6) Pipes & Redirection (With Examples)"
    echo "7) Variables & Simple Scripts"
    echo "8) Network Commands (curl, ping)"
    echo "9) Return to GUI Version"
    echo "0) Exit"
    echo "--------------------------------------------"
    read -p "Choose an option [1-0]: " choice
    case $choice in
        1) what_is_terminal ;;
        2) what_is_shell ;;
        3) basic_commands ;;
        4) navigation ;;
        5) files_dirs ;;
        6) pipes ;;
        7) variables ;;
        8) network_commands ;;
        9) if command -v yad &>/dev/null; then main_gui; else
              echo "GUI not available. Install yad first."
              sleep 2
              main_terminal
           fi ;;
        0) exit 0 ;;
        *) echo -e "\n❌ Invalid option. Please try again." ; sleep 1 ; main_terminal ;;
    esac
}

function what_is_terminal() {
    clear
    echo "📘 Lesson 1: Understanding the Terminal"
    echo "======================================="
    echo -e "\nThe terminal is a text-based way to interact with your computer."
    echo "While modern systems have graphical interfaces, the terminal remains powerful because:"
    echo " - It's fast and efficient"
    echo " - Can automate repetitive tasks"
    echo " - Works over remote connections"
    echo " - Gives you more control"
    
    echo -e "\n🔍 Try these commands to get started:"
    echo "1. 'whoami'    - Shows your username (will display output)"
    echo "2. 'date'      - Shows current date/time (will display output)"
    echo "3. 'clear'     - Clears the screen (no visible output)"
    echo "4. 'cal'       - Shows a calendar (will display output)"
    
    echo -e "\n💡 The terminal uses 'commands' (programs) that you type and execute by pressing Enter."
    echo "Everything is case-sensitive! 'WHOAMI' is different from 'whoami'."
    
    echo -e "\n🛑 Press any key to return to menu..."
    read -n 1 -s
    main_terminal
}

function what_is_shell() {
    clear
    echo "📘 Lesson 2: Understanding Shell and Bash"
    echo "========================================="
    echo -e "\nA 'shell' is a program that interprets your commands."
    echo "Bash (Bourne Again Shell) is the most common shell on Linux/macOS."
    
    echo -e "\nKey features:"
    echo " - Command execution"
    echo " - Tab completion (try pressing Tab)"
    echo " - Command history (press Up arrow)"
    echo " - Scripting capabilities"
    
    echo -e "\n🔍 Try these Bash features:"
    echo "1. Type 'echo hello' and press Enter"
    echo "2. Press Up arrow to recall the command"
    echo "3. Type 'ec' and press Tab to autocomplete"
    
    echo -e "\n💡 The prompt (usually ending with $) shows the shell is ready for commands."
    echo "The format is often: [user@host directory]$"
    
    echo -e "\n🛑 Press any key to return to menu..."
    read -n 1 -s
    main_terminal
}

function basic_commands() {
    clear
    echo "📘 Lesson 3: Essential Commands"
    echo "==============================="
    echo -e "\nLet's learn some fundamental commands:"
    
    echo -e "\n1. 'pwd' - Print Working Directory"
    echo "   Shows your current folder path (will display output)"
    
    echo -e "\n2. 'ls' - List files"
    echo "   Try:"
    echo "   - 'ls'          - Basic listing (shows output)"
    echo "   - 'ls -l'       - Detailed view (shows output)"
    echo "   - 'ls --help'   - Get help (shows output)"
    
    echo -e "\n3. 'cd' - Change Directory"
    echo "   Try:"
    echo "   - 'cd ~'       - Go to home (silent if successful)"
    echo "   - 'cd ..'      - Go up one level (silent)"
    echo "   - 'cd /tmp'    - Go to /tmp (silent)"
    
    echo -e "\n💡 Remember:"
    echo " - Commands can have 'options' (like -l) and 'arguments' (like /tmp)"
    echo " - 'man command' shows manual pages (try 'man ls')"
    echo " - Silent commands usually mean success - check with 'pwd' or 'ls'"
    
    echo -e "\n🔍 Try this sequence:"
    echo "1. 'pwd'         - See where you are"
    echo "2. 'ls'          - See what's here"
    echo "3. 'cd /tmp'     - Move to /tmp"
    echo "4. 'pwd'         - Confirm location"
    echo "5. 'ls'          - See temp files"
    echo "6. 'cd'          - Return home"
    echo "7. 'pwd'         - Confirm you're home"
    
    echo -e "\n🛑 Press any key to return to menu..."
    read -n 1 -s
    main_terminal
}
function network_commands() {
    clear
    echo "📘 Lesson 8: Basic Network Commands"
    echo "==================================="
    
    echo -e "\n🌐 Pinging Terminal Tutor server to wake it up..."
    if ping -c 2 terminal-tutor.glitch.me &> /dev/null; then
        echo "✅ Server is responding! Ready for network exercises."
    else
        echo "⚠️  Could not reach server, but we'll continue anyway."
    fi
    
    echo -e "\nCommands for working with networks and the internet:"
    
    echo -e "\n1. 'ping' - Check connection to a server"
    echo "   Example: 'ping -c 4 terminal-tutor.glitch.me'"
    echo "   - Sends 4 packets to our Terminal Tutor server"
    echo "   - Shows response time and success"
    echo "   - Press Ctrl+C to stop"
    
    echo -e "\n2. 'curl' - Transfer data from URLs"
    echo "   (Like a command-line web browser)"
    echo "   Basic usage: 'curl [URL]'"
    echo "   Examples with our server:"
    echo "   - 'curl https://terminal-tutor.glitch.me' - Get webpage"
    echo "   - 'curl -I https://terminal-tutor.glitch.me' - Show headers only"
    
    echo -e "\n3. 'ifconfig' or 'ip a' - Show network interfaces"
    echo "   (Displays your IP address and network info)"
    
    echo -e "\n💡 Pro Tip:"
    echo "Our Terminal Tutor server might take a few seconds to respond"
    echo "when first waking up. This is normal for free hosting services."
    
    echo -e "\n🛑 Press any key to return to menu..."
    read -n 1 -s
    main_terminal
}

# ========================
# INSTALLATION FUNCTIONS
# ========================

function install_system_wide() {
    yad --question --title="System Installation" \
        --text="This will install Terminal Tutor system-wide in /usr/local/bin. Continue?" \
        --button="Install:0" --button="Cancel:1"
    
    [ $? -ne 0 ] && return
    
    if sudo cp "$0" /usr/local/bin/terminal-tutor && sudo chmod +x /usr/local/bin/terminal-tutor; then
        yad --info --title="Success" \
            --text="Installation complete!\n\nYou can now run Terminal Tutor by typing:\n\n<tt>terminal-tutor</tt>\n\nin your terminal."
    else
        yad --error --title="Error" \
            --text="Failed to install. Try running with sudo."
    fi
}

# ========================
# MAIN EXECUTION
# ========================

# Start with GUI if available, otherwise terminal
if command -v yad &> /dev/null; then
    main_gui
else
    check_yad
fi