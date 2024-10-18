function Connect-StrongestOpenWifi {
    while ($true) {
        # Get available Wi-Fi networks
        $networks = netsh wlan show networks mode=bssid

        # Parse the output to find open networks
        $openNetworks = @()
        $ssid = ""
        $signalStrength = 0

        foreach ($line in $networks) {
            if ($line -match "SSID\s*:\s*(.+)") {
                $ssid = $matches[1].Trim()
            }
            if ($line -match "Signal\s*:\s*(\d+)%") {
                $signalStrength = [int]$matches[1]
            }
            if ($line -match "Authentication\s*:\s*Open") {
                $openNetworks += [PSCustomObject]@{
                    SSID = $ssid
                    Signal = $signalStrength
                }
            }
        }

        # Check if there are open networks
        if ($openNetworks.Count -eq 0) {
            Write-Host "No open Wi-Fi networks available."
            Start-Sleep -Seconds 60  # Wait for 60 seconds before retrying
            continue
        }

        # Find the strongest open network
        $strongestNetwork = $openNetworks | Sort-Object Signal -Descending | Select-Object -First 1

        # Connect to the strongest network
        Write-Host "Connecting to the strongest Wi-Fi: $($strongestNetwork.SSID)..."
        netsh wlan connect name=$strongestNetwork.SSID

        # Monitor for changes
        $previousSSID = $strongestNetwork.SSID
        while ($true) {
            $networks = netsh wlan show networks mode=bssid
            $openNetworks = @()

            foreach ($line in $networks) {
                if ($line -match "SSID\s*:\s*(.+)") {
                    $ssid = $matches[1].Trim()
                }
                if ($line -match "Signal\s*:\s*(\d+)%") {
                    $signalStrength = [int]$matches[1]
                }
                if ($line -match "Authentication\s*:\s*Open") {
                    $openNetworks += [PSCustomObject]@{
                        SSID = $ssid
                        Signal = $signalStrength
                    }
                }
            }

            if ($openNetworks.Count -eq 0) {
                Write-Host "No open Wi-Fi networks available."
                break
            }

            $currentStrongestNetwork = $openNetworks | Sort-Object Signal -Descending | Select-Object -First 1

            # If the strongest network changes, connect to the new one
            if ($currentStrongestNetwork.SSID -ne $previousSSID) {
                Write-Host "Switching to the new strongest Wi-Fi: $($currentStrongestNetwork.SSID)..."
                netsh wlan connect name=$currentStrongestNetwork.SSID
                $previousSSID = $currentStrongestNetwork.SSID
            }

            Start-Sleep -Seconds 60  # Check again after 60 seconds
        }
    }
}

# Run the function
Connect-StrongestOpenWifi
