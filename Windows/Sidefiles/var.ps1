$new_entry = 'c:\php'
$new_entry1 = 'C:\Apache24'
$new_entry2 = 'C:\Apache24\bin'

$old_path = [Environment]::GetEnvironmentVariable('path', 'machine');
$new_path = $old_path + ';' + $new_entry + ';' + $new_entry1 + ';' + $new_entry2
[Environment]::SetEnvironmentVariable('path', $new_path,'Machine');