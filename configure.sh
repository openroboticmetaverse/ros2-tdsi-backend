#!/bin/bash

# Print message in red
print_red() {
	echo -e "\e[31m$1\e[0m"
}

print_green() {
	echo -e "\e[32m$1\e[0m"
}

# Inform user to unplug joystick
print_red "Please unplug the joystick and press Enter to continue."
read -p "Press Enter when ready..."

# Store the result of ls /dev/input
before=$(ls /dev/input)

# Inform user to plug in the joystick
print_red "Now, please plug in the joystick and press Enter to continue."
read -p "Press Enter when ready..."

print_green "Sleeping for 5 seconds ....."
# Wait for a moment to let the system detect the joystick
sleep 5

# Run ls again and compare the result
after=$(ls /dev/input)

# Show only the newly created files
new_files=$(comm -13 <(echo "$before" | sort) <(echo "$after" | sort))

# Create the string /dev/input/result
placeholder="JOYSTICK"
cp compose.yaml.temp /tmp/template.txt
if [ -n "$new_files" ]; then
	while IFS= read -r file; do
		result="\/dev\/input\/$file:\/dev\/input\/$file"
		sed -i "s/$placeholder/$result/g" /tmp/template.txt
		placeholder=EVENT
	done <<<"$new_files"
	cp -f /tmp/template.txt compose.yaml
else
	echo "No new files detected, and thus no info about pluged joystick"
fi
