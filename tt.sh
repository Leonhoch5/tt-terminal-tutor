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

# Function to ping the Terminal Tutor website
function ping_tutor_website() {
    echo -e "\n🌐 Pinging Terminal Tutor server to wake it up..."
    echo "This ensures our examples will work properly."
    echo -e "(Glitch apps go to sleep when not in use)\n"
    
    if ping -c 2 terminal-tutor.glitch.me &> /dev/null; then
        echo "✅ Server is responding! Ready for network exercises."
    else
        echo "⚠️  Could not reach server, but we'll continue anyway."
        echo "Some examples might be slower to respond."
    fi
    
    echo -e "\nNow trying a quick HTTP request to wake up the service..."
    if curl -s -I https://terminal-tutor.glitch.me | grep -q "HTTP"; then
        echo "✅ Website is awake and responding!"
    else
        echo "⚠️  Website might be slow to respond. Please be patient."
    fi
    echo -e "\nThis automatic ping helps ensure the examples will work properly."
}

# Section 1 - Terminal introduction
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

# Section 2 - Shell explanation
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
    
    echo -e "\n🛑 Type 'exit' when you're done practicing.\n"
    
    bash --rcfile <(echo 'PS1="[Bash Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Section 3 - Basic commands
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

# Section 4 - Navigation
function navigation() {
    clear
    echo "📘 Lesson 4: File System Navigation"
    echo "=================================="
    echo -e "\nLinux/macOS use a tree-like file structure starting at / (root)"
    
    echo -e "\nKey concepts:"
    echo " - / is the root directory"
    echo " - ~ is your home directory"
    echo " - . is current directory"
    echo " - .. is parent directory"
    
    echo -e "\n🔍 Try this exercise:"
    echo "1. 'pwd'          - See current location"
    echo "2. 'ls'           - View contents"
    echo "3. 'cd /usr'      - Change directory"
    echo "4. 'ls bin'       - View bin subdirectory"
    echo "5. 'cd' or 'cd ~' - Return home"
    
    echo -e "\n💡 Paths can be:"
    echo " - Absolute (start with /): /home/user/file"
    echo " - Relative: docs/file.txt"
    
    echo -e "\n🛑 Practice moving around, then type 'exit'.\n"
    
    bash --rcfile <(echo 'PS1="[Navigation Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Section 5 - Files and directories
function files_dirs() {
    clear
    echo "📘 Lesson 5: Working with Files and Directories"
    echo "=============================================="
    echo -e "\nCreating and managing files:"
    
    echo -e "\nDirectory commands:"
    echo " - 'mkdir folder'    - Create directory"
    echo " - 'rmdir folder'    - Remove empty directory"
    echo " - 'rm -r folder'    - Remove directory and contents"
    
    echo -e "\nFile commands:"
    echo " - 'touch file.txt'  - Create empty file"
    echo " - 'nano file.txt'   - Edit in nano (Ctrl+X to save)"
    echo " - 'cat file.txt'    - View contents"
    echo " - 'cp file.txt copy.txt' - Copy file"
    echo " - 'mv file.txt newname.txt' - Rename/move"
    echo " - 'rm file.txt'     - Remove file"
    
    echo -e "\n🔍 Try this:"
    echo "1. 'mkdir test'"
    echo "2. 'cd test'"
    echo "3. 'touch hello.txt'"
    echo "4. 'echo \"Hello\" > hello.txt'"
    echo "5. 'cat hello.txt'"
    echo "6. 'cd ..'"
    echo "7. 'rm -r test'"
    
    echo -e "\n⚠️ Warning: 'rm' is permanent! No recycle bin!"
    
    echo -e "\n🛑 Practice these, then type 'exit'.\n"
    
    bash --rcfile <(echo 'PS1="[File Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Section 6 - Pipes and redirection
function pipes() {
    clear
    echo "📘 Lesson 6: Pipes and Redirection"
    echo "=================================="
    echo -e "\nPipes (|) send output from one command to another:"
    echo " - 'command1 | command2'"
    
    echo -e "\nRedirection:"
    echo " - '>' - Overwrite file"
    echo " - '>>' - Append to file"
    echo " - '<' - Read from file"
    
    echo -e "\n🔍 Examples to try:"
    echo "1. 'ls /usr/bin | grep zip' - Find programs with 'zip'"
    echo "2. 'echo \"Hello\" > greeting.txt' - Create file"
    echo "3. 'date >> greeting.txt' - Append date"
    echo "4. 'sort < greeting.txt' - Sort file contents"
    echo "5. 'ls -l | more' - View page by page"
    
    echo -e "\n💡 Common text processing commands:"
    echo " - grep (search)"
    echo " - sort"
    echo " - uniq"
    echo " - wc (word count)"
    
    echo -e "\n🛑 Experiment, then type 'exit'.\n"
    
    bash --rcfile <(echo 'PS1="[Pipe Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Section 7 - Variables and scripts
function variables() {
    clear
    echo "📘 Lesson 7: Variables and Simple Scripts"
    echo "========================================"
    echo -e "\nVariables store data for later use:"
    echo " - 'name=\"Alice\"' creates a variable"
    echo " - 'echo \$name' uses it (note the \$)"
    
    echo -e "\nEnvironment variables (try these):"
    echo " - 'echo \$USER' - Your username"
    echo " - 'echo \$HOME' - Your home directory"
    echo " - 'echo \$PATH' - Where Bash looks for programs"
    
    echo -e "\nCreating a simple script:"
    echo "1. 'nano greet.sh'"
    echo "2. Add these lines:"
    echo "   #!/bin/bash"
    echo "   echo \"Hello, \$1!\""
    echo "3. Save (Ctrl+O, Enter, Ctrl+X)"
    echo "4. 'chmod +x greet.sh' - Make executable"
    echo "5. './greet.sh Bob' - Run it"
    
    echo -e "\n💡 Special variables:"
    echo " - \$0 - Script name"
    echo " - \$1, \$2... - Arguments"
    echo " - \$? - Exit status"
    
    echo -e "\n🛑 Practice scripting, then type 'exit'.\n"
    
    bash --rcfile <(echo 'PS1="[Script Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}

# Section 8 - Network commands
function network_commands() {
    clear
    echo "📘 Lesson 8: Basic Network Commands"
    echo "==================================="
    
    # Ping the Glitch website to wake it up
    ping_tutor_website
    
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
    echo "   Common flags:"
    echo "     - '-O' save file with original name"
    echo "     - '-L' follow redirects"
    echo "     - '-v' verbose output (for debugging)"
    
    echo -e "\n3. 'wget' - Another download tool"
    echo "   Example:"
    echo "   - 'wget https://terminal-tutor.glitch.me'"
    
    echo -e "\n4. 'ifconfig' or 'ip a' - Show network interfaces"
    echo "   (Displays your IP address and network info)"
    
    show_feedback
    
    echo -e "\n🔍 Try these exercises with our server:"
    echo "1. Check connection to our server:"
    echo "   'ping -c 2 terminal-tutor.glitch.me'"
    echo "2. View the website content:"
    echo "   'curl https://terminal-tutor.glitch.me'"
    echo "3. Check just the headers:"
    echo "   'curl -I https://terminal-tutor.glitch.me'"
    echo "4. View your network info:"
    echo "   'ip a' or 'ifconfig'"
    
    echo -e "\n💡 Pro Tip:"
    echo "Our Terminal Tutor server might take a few seconds to respond"
    echo "when first waking up. This is normal for free hosting services."
    
    echo -e "\n⚠️ Note: Some network commands may require special permissions."
    echo "If you get permission errors, try with 'sudo' (admin privileges)."
    
    echo -e "\n🛑 Practice these, then type 'exit' to return.\n"
    
    bash --rcfile <(echo 'PS1="[Network Practice] \$ "; trap "echo -e \"\nReturning to menu...\"; exit" EXIT')
    main_menu
}


# Start the application
echo -e "Starting Terminal Tutor...\n"
sleep 1
main_menu