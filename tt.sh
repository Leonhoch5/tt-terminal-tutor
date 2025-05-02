#!/bin/bash

# Main menu function
function main_menu() {
    clear
    echo "============================================"
    echo "  🐧 Welcome to Terminal Tutor (Beginners)  "
    echo "============================================"
    echo "1) What is the terminal? (Introduction)"
    echo "2) Understanding the Shell and Bash"
    echo "3) Basic Commands (Hands-on Practice)"
    echo "4) File System Navigation (Step-by-Step)"
    echo "5) Working with Files and Directories"
    echo "6) Pipes & Redirection (With Examples)"
    echo "7) Variables & Simple Scripts"
    echo "8) Network Commands (curl, ping)"
    echo "9) Exit"
    echo "--------------------------------------------"
    read -p "Choose a lesson [1-9]: " choice
    case $choice in
        1) what_is_terminal ;;
        2) what_is_shell ;;
        3) basic_commands ;;
        4) navigation ;;
        5) files_dirs ;;
        6) pipes ;;
        7) variables ;;
        8) network_commands ;;
        9) exit 0 ;;
        *) echo -e "\n❌ Invalid option. Please try again." ; sleep 1 ; main_menu ;;
    esac
}

# Helper function to show command feedback
function show_feedback() {
    echo -e "\n💬 Command Feedback:"
    echo "-------------------"
    echo "Note: Some commands show output, while others work silently."
    echo "If a command doesn't show output, it usually means it succeeded."
    echo "You can check results with commands like 'ls' or 'cat'."
    echo "Some commands will only show errors if something goes wrong."
    echo -e "-------------------\n"
}

# Section 1 - More detailed introduction
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
    
    show_feedback
    
    echo "🔍 Try these commands to get started:"
    echo "1. 'whoami'    - Shows your username (will display output)"
    echo "2. 'date'      - Shows current date/time (will display output)"
    echo "3. 'clear'     - Clears the screen (no visible output)"
    echo "4. 'cal'       - Shows a calendar (will display output)"
    
    echo -e "\n💡 The terminal uses 'commands' (programs) that you type and execute by pressing Enter."
    echo "Everything is case-sensitive! 'WHOAMI' is different from 'whoami'."
    
    echo -e "\n🛑 To return to the menu, type 'exit' or press Ctrl+D\n"
    
    bash --rcfile <(echo 'PS1="[Terminal Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# New section for network commands
function network_commands() {
    clear
    echo "📘 Lesson 8: Basic Network Commands"
    echo "==================================="
    echo -e "\nCommands for working with networks and the internet:"
    
    echo -e "\n1. 'ping' - Check connection to a server"
    echo "   Example: 'ping -c 4 google.com'"
    echo "   - Sends 4 packets to Google's server"
    echo "   - Shows response time and success"
    echo "   - Press Ctrl+C to stop"
    
    echo -e "\n2. 'curl' - Transfer data from URLs"
    echo "   (Like a command-line web browser)"
    echo "   Basic usage: 'curl [URL]'"
    echo "   Examples:"
    echo "   - 'curl https://example.com' - Get webpage"
    echo "   - 'curl -O https://example.com/file.zip' - Download file"
    echo "   - 'curl -I https://example.com' - Show headers only"
    
    echo -e "\n3. 'wget' - Another download tool"
    echo "   Example: 'wget https://example.com/file.zip'"
    
    echo -e "\n4. 'ifconfig' or 'ip a' - Show network interfaces"
    echo "   (Displays your IP address and network info)"
    
    show_feedback
    
    echo -e "\n🔍 Try these exercises:"
    echo "1. Check if you can connect to Google:"
    echo "   'ping -c 2 google.com'"
    echo "2. Download a test file:"
    echo "   'curl -O https://example.com'"
    echo "3. View your IP address:"
    echo "   'ip a' or 'ifconfig'"
    
    echo -e "\n⚠️ Note: Some network commands may not work in all environments."
    echo "If you get permission errors, try with 'sudo' (we'll explain this later)."
    
    echo -e "\n🛑 Practice these, then type 'exit' to return.\n"
    
    bash --rcfile <(echo 'PS1="[Network Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}
# [Previous sections 2-7 would be here with similar enhancements...]
# For brevity, I'm showing just the new/changed sections, but all sections
# should get the show_feedback treatment and clearer explanations

# Section 3 - More structured command practice
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
    
    show_feedback
    
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
    
    echo -e "\n🛑 Practice these, then type 'exit' to return.\n"
    
    bash --rcfile <(echo 'PS1="[Command Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Start the application
echo -e "Starting Terminal Tutor...\n"
sleep 1
main_menu