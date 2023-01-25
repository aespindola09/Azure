filepath = "c:\scripts\servers.csv" 
$servers = Import-CSV $filepath -delimiter "," 

Foreach ($server in $servers) {
     write-host $server

}

