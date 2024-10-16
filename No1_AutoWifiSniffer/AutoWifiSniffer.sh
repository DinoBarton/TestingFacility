#!/bin/bash

# Function to search for available networks
search_for_networks() {
    nmcli -t -f SSID,SIGNAL dev wifi
}

# Function to alert the user
alert_user() {
    echo "$1"
}

# Function to connect to a network
connect_to_network() {
    nmcli dev wifi connect "$1"
}

# Main loop
while true; do
    networks=$(search_for_networks)
    
    # Filter open networks
    open_networks=()
    while IFS=: read -r ssid signal; do
        # Assuming networks without a password are open
        open_networks+=("$ssid:$signal")
    done <<< "$networks"

    # Check if there are open networks
    if [ ${#open_networks[@]} -eq 0 ]; then
        alert_user "No open Wi-Fi networks available."
        sleep 60  # Wait for 60 seconds before retrying
        continue
    fi

    # Sort networks by signal strength
    strongest_network=$(printf "%s\n" "${open_networks[@]}" | sort -t: -k2 -nr | head -n1 | cut -d: -f1)

    # Connect to the strongest network
    connect_to_network "$strongest_network"

    previous_strongest="$strongest_network"
    
    # Monitor for network changes
    while true; do
        networks=$(search_for_networks)

        # Filter open networks
        open_networks=()
        while IFS=: read -r ssid signal; do
            open_networks+=("$ssid:$signal")
        done <<< "$networks"

        # Check if there are open networks
        if [ ${#open_networks[@]} -eq 0 ]; then
            alert_user "No open Wi-Fi networks available."
            break
        fi

        # Get the current strongest network
        current_strongest=$(printf "%s\n" "${open_networks[@]}" | sort -t: -k2 -nr | head -n1 | cut -d: -f1)

        # If the strongest network changes, connect to the new one
        if [ "$current_strongest" != "$previous_strongest" ]; then
            connect_to_network "$current_strongest"
            previous_strongest="$current_strongest"
        fi

        sleep 60  # Check again after 60 seconds
    done
done
