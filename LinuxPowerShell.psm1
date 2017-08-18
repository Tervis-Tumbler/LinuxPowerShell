function Invoke-LinuxCommand {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName,
        $Credential,
        [Parameter(Mandatory)]$Command
    )
    process {
        $SSHSession = Get-SSHSession -ComputerName $ComputerName
        
        $Session = if ($SSHSession) { 
            $SSHSession 
        } else {
            New-SSHSession -Credential $Credential -ComputerName $ComputerName
        }

        Invoke-SSHCommand -SSHSession $Session -Command $Command |
        Select -ExpandProperty Output
    }
}

function Get-LinuxPackageInstalled {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName,
        [Parameter(Mandatory)]$PackageName,
        $Credential
    )
    process {
        Invoke-LinuxCommand -ComputerName $ComputerName -Credential $Credential -Command "yum list installed $PackageName"
    }
}

function Get-YumConf {
 cat /etc/yum.conf
}

function Get-YumRepo {
ls /etc/yum.repos.d/
}

function Get-YumRepoContent {

}