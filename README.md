# How to use this Script

This script is designed to run a network speed test via command line with logging. The results will be added to the text.csv file. 

## Requirements

All of the files in this repository are required to succesfully test network speeds and log the results with as little interaction by the user running the script. 

Network connectivity is also a requirement (_obviously_) to successfully run a network speed test. 

## How it works

Using Ookla's (speedtest.net) CLI executable, this script will execute the command line utility. (`speedtest.md` contains the full documentation for the CLI utility for refrence.) If you manually run the CLI utility, you will be prompted to accept a EULA. I've been able to bypass that by packaging the file generated when the EULA is accepted and unzipping it to the location where the utility stores the file. The script checks if the directory exists, and if it doesn't, it will unzip the directory before proceeding to the CLI utility. 

The script will also wait for network connectivity to `google.com` before proceeding. It will attempt a ping on a loop for five seconds before giving a failure message. 

If the network connectivity test passes, it will proceed to run the CLI utility.

The output of the `speedtest.exe` CLI utility is then stored as a variable and combined with more information the script pulls or is manually entered at the time of running the script, concatenates them, and then appends the data to the end of the `test.csv` file to store the results. 

**DO NOT KEEP THE `test.csv` FILE OPEN WHEN RUNNING THE SCRIPT OR ELSE THE RESULTS WILL NOT SAVE**

## Running the script

Open a PowerShell session in the directory where all the files are located. Run `./speedtest.ps1` in the PowerShell window. You will be prompted to enter two pieces of information before the script will proceed. `Building` and `Room Number`.

When the speed test is complete, you will see a `DONE!` message and you can unplug the network cable and move to the next location. 

In the event there is some kind of failure, you will see a message on screen which reads `Test Failure Occured`. It will also log the failure to the CSV file. 

### Information gathered in the `test.csv` file
*The fields with an `*` denote fields added which are not part of the `speedtest.exe` CLI utility

- Date*
- Building*
- Room*
- Computer IP*
- server name
- server id
- latency
- jitter
- packet loss
- download
- upload
- download bytes
- upload bytes
- share url
