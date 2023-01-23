winget install emacs
$emacs_config_url="https://raw.githubusercontent.com/ProgKea/windows_config/master/init.el"
curl.exe $emacs_config_url -o $env:APPDATA/.emacs
winget install powertoys