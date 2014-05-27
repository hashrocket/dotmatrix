# Print functions
print_padded() {
  len=${#2}
  printf "%-40s [%$((len+(10-len)/2))s%$(((10-len)/2))s]\n" "$1" "$2" " "
}

create_notice() {
  print_padded "Creating $1" "$2"
}


skip_notice() {
  print_padded "Skipping $1" "$2"
}

copy_notice() {
  print_padded "Copying  $1" "$2"
}

link_notice() {
  print_padded "Linking  $1" "$2"
}

remove_notice() {
  print_padded "Removing $1" "$2"
}

# Other functions

directory_warning() {
  name=$(basename $0)
  if [[ ! "$PWD/bin/$name" -ef "$0" ]]; then
    echo "Please run '$name' from dotmatrix root folder"
    exit 1
  fi
}
