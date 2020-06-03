pushd %~dp0

:: Kill a previous version
plink -ssh -pw raspberry pi@192.168.2.17 "sudo killall -s SIGKILL dotnet /home/pi/Desktop/rpitest/RemoteDebugWebApplication.dll"

:: Build the project and publish it to the Raspberry Pi
::dotnet publish -r linux-arm /p:ShowLinkerSizeComparison=true --self-contained false
dotnet publish -p:PublishProfile=Properties\PublishProfiles\RemoteDebug.pubxml
pushd .\bin\Debug\netcoreapp3.1\linux-arm\publish
pscp -pw raspberry -v -r .\* pi@192.168.2.17:/home/pi/Desktop/rpitest
popd


:: Start the program on the Raspberry Pi
plink -pw raspberry pi@192.168.2.17 "dotnet /home/pi/Desktop/rpitest/RemoteDebugWebApplication.dll"
::putty -ssh -pw raspberry pi@192.168.2.17 -m remote.cmd

popd
