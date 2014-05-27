# colors

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
normal=$(tput sgr0)

# Print functions

print_padded() {
  len=${#2}
  printf "%-50s [$3%$((len+(10-len)/2))s%$(((10-len)/2))s$normal]\n" "$1" "$2"
}

create_notice() {
  print_padded "Creating $1" "$2" $green
}


skip_notice() {
  print_padded "${yellow}Skipping${normal} $1" "$2" $yellow
}

copy_notice() {
  print_padded "${green}Copying${normal}  $1" "$2" $green
}

link_notice() {
  print_padded "${green}Linking${normal}  $1" "$2" $green
}

remove_notice() {
  print_padded "${red}Removing${normal} $1" "$2" $red
}

# Other functions

directory_warning() {
  name=$(basename $0)
  if [[ ! "$PWD/bin/$name" -ef "$0" ]]; then
    echo "${yellow}Please run '$name' from dotmatrix root folder${normal}"
    exit 1
  fi
}

dirty_warning() {
  if [ -n "$(git status --porcelain)" ]; then
    echo "${red}ERROR: You have a dirty working copy.${normal}"
    echo "Commit or clean any changes, and run bin/upgrade again."
    exit 1
  fi
}
