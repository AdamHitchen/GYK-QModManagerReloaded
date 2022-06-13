﻿param($installPath, $toolsPath, $package, $project)

$analyzersDir = Join-Path (Split-Path -Path $toolsPath -Parent) "analyzers"
if (-Not (Test-Path $analyzersDir))
{
    return
}

$analyzersPaths = Join-Path ( $analyzersDir ) * -Resolve

foreach($analyzersPath in $analyzersPaths)
{
    # Install the language agnostic analyzers.
    if (Test-Path $analyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $analyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Add($analyzerFilePath.FullName)
            }
        }
    }
}

# $project.Type gives the language name like (C# or VB.NET)
$languageFolder = ""
if($project.Type -eq "C#")
{
    $languageFolder = "cs"
}
if($project.Type -eq "VB.NET")
{
    $languageFolder = "vb"
}
if($languageFolder -eq "")
{
    return
}

foreach($analyzersPath in $analyzersPaths)
{
    # Install language specific analyzers.
    $languageAnalyzersPath = join-path $analyzersPath $languageFolder
    if (Test-Path $languageAnalyzersPath)
    {
        foreach ($analyzerFilePath in Get-ChildItem $languageAnalyzersPath -Filter *.dll)
        {
            if($project.Object.AnalyzerReferences)
            {
                $project.Object.AnalyzerReferences.Add($analyzerFilePath.FullName)
            }
        }
    }
}
# SIG # Begin signature block
# MIIoqQYJKoZIhvcNAQcCoIIomjCCKJYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCh1voBODYpfCet
# zwmmor0XvG3ngI9/l8E/7NCzPBjyWaCCDfAwggZuMIIEVqADAgECAhMzAAACjX5H
# w4J+BRoqAAAAAAKNMA0GCSqGSIb3DQEBDAUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjExMDE0MTg0NTE0WhcNMjIxMDEzMTg0NTE0WjBjMQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMQ0wCwYDVQQDEwQuTkVU
# MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAz6djBvGQeEXcJBPGF9t+
# rTJj2I2Z/6+mxfIev5bXiw0pbZWY3jzDBS20WCQSVlZcNHv8tWspGM3XBRbL9vOw
# VOjJ0yyIjM1PUdSK8x95P9zKSlM39xUv9m+8aueEl5dASfXGucY2pbemzQ2NBAs9
# 3Z+8jLVj9gAiH2vb50eRiP5WOYS2/2/uvaNu2SVbDo4WA7CQHx8YD7XlCKfL7V0T
# la8i0uP8Mas+YJbPgxWB8bjae0TjzUUvLhTvisEQO1o1qE609RJLzJONR40iCLd5
# OTOdK162eOCv4GfQijgqEyqTADtxq/nDGU5FNT85N0zo9UmvDo0oLojO0qp46OUW
# zbqHVzl4FjpkohsHA2QNC5Kr8/naA6OxPOH+z70k/BtfOv+mWsBchdmHXvwdOuyv
# mA/2Jo9dYgwO+UwXDnixpkHrweH4PVeIAqY69y3h612Ty/zCUn3o7ePxLaiiZJ2p
# wAt7JxzuFWeknyPqEVVb2FcVGpJv1VifXxwy7m7da8iRAgMBAAGjggF+MIIBejAf
# BgNVHSUEGDAWBgorBgEEAYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUHgevMUhF
# qAngfzHomhzHqKBeXs4wUAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29m
# dCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMRYwFAYDVQQFEw00NjQyMjMrNDY4NjI2
# MB8GA1UdIwQYMBaAFEhuZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBH
# oEWGQ2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNp
# Z1BDQTIwMTFfMjAxMS0wNy0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUF
# BzAChkVodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0Nv
# ZFNpZ1BDQTIwMTFfMjAxMS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG
# 9w0BAQwFAAOCAgEAHiqaRgbuQorcDr+hk14g/0mE2DtJf5WdpxAa7AgdbZPEgI5t
# VRWHs+ryb7Eb0RyjhaXwCgCuE5aencgxYWIX6/EYPvNomkbvuTEVcN7CwDw+d6HC
# cx8erpOWIjn/rn4VkHgp/kTLXqzZCTqdNKr9uyBPnvZoKRT2E93lZe6SFF+5A6da
# fqVFZESFyoBF64WaKTlgP6GAlmCjewINzTWFUSA4h3CCNcwQ0AusCBpCWn9AVFf4
# MxGlb3p7IWgoVFaJG50GG1Kp/0j5aZODMr1BK2BPyaeeNpjvR/z91yqzSe/jCtZv
# jfzBPXF13IitBcyc5thkKpvskM1M99Gkql8DKTCFGYAkMO8Of/M2aXP+9xpTj5Yu
# 0FXbOnKTihVxnMmAxaAaXeB2Dz580BwuhDB9GqT7Bglxy74hfyVHSH4LKCiY8oAu
# bFJvZKEmxTcFdd3oTXfk+AKQ+y/Hee3J6ittwCyFQ4hqolqZM51aQ1/lf3tChMMS
# 4+xLa0jMjea6e+0NnXifKTJiN/h5fw1HqkDA4SAytZDXi1pIqroxpc25wZqoLMXD
# 8v7inXXmJls6jr34646FtU0Ha0hmN4pgTtAopT6UB3OBlRpzJr4yDUq7ed0Z28MH
# whPvflzedTfwtXxi263mPG9qIDWibcM26Z9U0AhMeCckXynvHUPMgDk1rHYwggd6
# MIIFYqADAgECAgphDpDSAAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQg
# Um9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDla
# Fw0yNjA3MDgyMTA5MDlaMH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEw
# ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS6
# 8rZYIZ9CGypr6VpQqrgGOBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15
# ZId+lGAkbK+eSZzpaF7S35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+er
# CFDPs0S3XdjELgN1q2jzy23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVc
# eaVJKecNvqATd76UPe/74ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGM
# XeiJT4Qa8qEvWeSQOy2uM1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/
# U7qcD60ZI4TL9LoDho33X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwj
# p6lm7GEfauEoSZ1fiOIlXdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwC
# gl/bwBWzvRvUVUvnOaEP6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1J
# MKerjt/sW5+v/N2wZuLBl4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3co
# KPHtbcMojyyPQDdPweGFRInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfe
# nk70lrC8RqBsmNLg1oiMCwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAw
# HQYDVR0OBBYEFEhuZOVQBdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoA
# UwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQY
# MBaAFHItOgIxkEO5FAVO4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6
# Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1
# dDIwMTFfMjAxMV8wM18yMi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAC
# hkJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1
# dDIwMTFfMjAxMV8wM18yMi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4D
# MIGDMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3Bz
# L2RvY3MvcHJpbWFyeWNwcy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBs
# AF8AcABvAGwAaQBjAHkAXwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcN
# AQELBQADggIBAGfyhqWY4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjD
# ctFtg/6+P+gKyju/R6mj82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw
# /WvjPgcuKZvmPRul1LUdd5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkF
# DJvtaPpoLpWgKj8qa1hJYx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3z
# Dq+ZKJeYTQ49C/IIidYfwzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEn
# Gn+x9Cf43iw6IGmYslmJaG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1F
# p3blQCplo8NdUmKGwx1jNpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0Qax
# dR8UvmFhtfDcxhsEvt9Bxw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AAp
# xbGbpT9Fdx41xtKiop96eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//W
# syNodeav+vyL6wuA6mk7r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqx
# P/uozKRdwaGIm1dxVk5IRcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIaDzCC
# GgsCAQEwgZUwfjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEo
# MCYGA1UEAxMfTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAo1+
# R8OCfgUaKgAAAAACjTANBglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYK
# KwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG
# 9w0BCQQxIgQgscbk7KKN8M4zlvGIkWbJVqzLt3vnYcsDip+8ebtDMX0wQgYKKwYB
# BAGCNwIBDDE0MDKgFIASAE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbTANBgkqhkiG9w0BAQEFAASCAYAfekyfnE+Kis2TZvbNMyHp
# aNSC+2+WMDR+WB3NljSCVKA48yhUiPjyqztAK+RYvhDLG3cqz6Td8ZnbukkxyM2b
# S/Q7hQGT+IODi5AwhW9pqmtozGGTrQ/PbOKcf2yuFHUz7u5ABZUJajrcySAVMWK6
# S71BxIChBUj74TFIbR5iiNqipaKkMvopzPpjByvqqNgRiqTR+cPCxkWSCcRYAwx8
# +yOii9oxIYoBxobpwwfJtDDkYYPLn+GBdoXUaO4XuLGKX98mbktjwtwQ8Sc3NtSH
# BJ438XV7dCfGjs3tJRGkN2HoAW8auI5AQl7+hSODUJIimEOr6BWn0CLpoyVIlMYZ
# 8SFCeWZ5DyMjfUcXDdXaZXlaL4UYCarMbfXlJ3Iv0xbPyTW+xBpyDFZu8xDLAdUY
# YRz/9MT/aqMQvfLIpiv4P5/pgaviNY98+jV+t6pt4iJJgXZe+/LAkyDb74I4Jn+J
# VRkkxQ1dmB9sMYpdXmsJgvVCfX7guAVjNZtYGP0RaJihghcZMIIXFQYKKwYBBAGC
# NwMDATGCFwUwghcBBgkqhkiG9w0BBwKgghbyMIIW7gIBAzEPMA0GCWCGSAFlAwQC
# AQUAMIIBWQYLKoZIhvcNAQkQAQSgggFIBIIBRDCCAUACAQEGCisGAQQBhFkKAwEw
# MTANBglghkgBZQMEAgEFAAQgL8Xr6UDkm0NJfTX84McYvpXo8TS+CxFPfxGFZzmG
# FlgCBmIXtubFBxgTMjAyMjA0MTcxMjEyNDMuMDI0WjAEgAIB9KCB2KSB1TCB0jEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWlj
# cm9zb2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFs
# ZXMgVFNTIEVTTjo4RDQxLTRCRjctQjNCNzElMCMGA1UEAxMcTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgU2VydmljZaCCEWgwggcUMIIE/KADAgECAhMzAAABiC7NxoFB4bwq
# AAEAAAGIMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpX
# YXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQg
# Q29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAy
# MDEwMB4XDTIxMTAyODE5Mjc0MFoXDTIzMDEyNjE5Mjc0MFowgdIxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJ
# cmVsYW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046OEQ0MS00QkY3LUIzQjcxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2UwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCa5xAIBCaR
# xcfIOtXhLzxV4mDZcao0pxamytqlEoVZyGGMux/8z1c31uDOcs3jwFc8C06XCh50
# HaQ3htl08/cp1E1tirW00VSHxSeaMIKv4KMuWuKAdyZLRH6uw3aAExeUsRmHZb8I
# 64P1U4uxvY/aMOnjfdXitQABRbzYzuuDzV3c5xy077VdbWHcS1tC1LpASTDoNgi6
# 99fsDDyNcdmewy6A/xkDWi2mulM1SH/NFYLsInIHPKZAgNIJ1aFV8PiyHF75GzrV
# rF/bttODkf9X9KQ132HMzo2r/LY6MMqsu2432FLnfnr26FM1B4CEBUN94ekTOUy+
# 1c7JfoxOZ7eOcd0c+PoYtP0AxEisB/3qE9g6I8QG8e2uDoymIjf6Xo2VtI6zXr8V
# N6WNPX6x2xYa0VNm95r2kCpXVoHv3loOSZnqxGbmO12dVrN+hasd3e8N6HflZXTy
# 9bhOU58RxXb4ptqKs/FoWQnj62Wwn4x+xU6JOv9mcOBoxoefPOiB6UjcCh8NT0hN
# syRO1PGss/KBNtF21um2ucvMGfaPNHhMl+RCj6HNa5oy7k60xmIpXYjkw7SbWYq5
# QCCir7jjYvDwJC6P0QLYXydNslvY1xQOD7vh2AmKz8/wFr86uXFb5OuBzpM8bEI6
# 1Pvf1Sp6yW9YPqs1DpQQ71/u9YOSF3a+2wIDAQABo4IBNjCCATIwHQYDVR0OBBYE
# FGR5tVDEo7vOu736jbsaM+WMyUpKMB8GA1UdIwQYMBaAFJ+nFV0AXmJdg/Tl0mWn
# G1M1GelyMF8GA1UdHwRYMFYwVKBSoFCGTmh0dHA6Ly93d3cubWljcm9zb2Z0LmNv
# bS9wa2lvcHMvY3JsL01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAyMDEw
# KDEpLmNybDBsBggrBgEFBQcBAQRgMF4wXAYIKwYBBQUHMAKGUGh0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY2VydHMvTWljcm9zb2Z0JTIwVGltZS1TdGFt
# cCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYI
# KwYBBQUHAwgwDQYJKoZIhvcNAQELBQADggIBAEAQWtv7WAgmy/8YotLbNq+bZ6TX
# vuaTjK7oG5LpWIi4vR7bRg3Z11d6JSER2GTcVG2j8YP3eTlIjI0npf6ny5Aw7Ejb
# dg5J3ITMsnCHv5+27Qh/zLfHoAnRLV3XY5nt+xiqWMdR5xyd5L0NaqKkeTy4zybZ
# lsGFGdQ3wziKqDiugkaZkpn0VzxntkcmAz3uLt8jID2EkfTXvPblasMmXFqkPl2Y
# zI3LPN8BWpoHJ6YKgGfhWREIY0hLHTFGVxv3dboQ2EkXU0GMyXdwpUQdbh3xjQ1m
# Gl1cO14uT0eBsnJ4IjZ830YGsJLUHVqT7X3g8aJkovz6C0rs2isCgAxC8WRiCset
# YJh+NXo+i4Lc34DrA4GtyRU4dP09QgMrkAMIfhmtpCJ15L0sP+KYoczcjiJrM+Sh
# wdwUcH3Kjl32Uwln6mcABaCVBCMxaFSqcT+WUD4SqNs7SUDGWZS1WKhVSzCFPekr
# oOMVFcz8tTHBO225/PXMGMQuREhny4LLViQzF8EXASiz9AUiUNoVK9SfgiJZkDdU
# t8ASPLnWInAraNIgfD7VuMIj4UEdwJNEfak/f6HkOVDkBn929x82sBM/XDDPbkiv
# wqAo5sdEIhgfhUjZWuY5uhIcUbv0lsd2Q9VKN8vFO5OyiHkXOhTW3m6sbSvC6Whl
# kVnFOSvF/JOSG+aMMIIHcTCCBVmgAwIBAgITMwAAABXF52ueAptJmQAAAAAAFTAN
# BgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9y
# aXR5IDIwMTAwHhcNMjEwOTMwMTgyMjI1WhcNMzAwOTMwMTgzMjI1WjB8MQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCC
# AgoCggIBAOThpkzntHIhC3miy9ckeb0O1YLT/e6cBwfSqWxOdcjKNVf2AX9sSuDi
# vbk+F2Az/1xPx2b3lVNxWuJ+Slr+uDZnhUYjDLWNE893MsAQGOhgfWpSg0S3po5G
# awcU88V29YZQ3MFEyHFcUTE3oAo4bo3t1w/YJlN8OWECesSq/XJprx2rrPY2vjUm
# ZNqYO7oaezOtgFt+jBAcnVL+tuhiJdxqD89d9P6OU8/W7IVWTe/dvI2k45GPsjks
# UZzpcGkNyjYtcI4xyDUoveO0hyTD4MmPfrVUj9z6BVWYbWg7mka97aSueik3rMvr
# g0XnRm7KMtXAhjBcTyziYrLNueKNiOSWrAFKu75xqRdbZ2De+JKRHh09/SDPc31B
# mkZ1zcRfNN0Sidb9pSB9fvzZnkXftnIv231fgLrbqn427DZM9ituqBJR6L8FA6PR
# c6ZNN3SUHDSCD/AQ8rdHGO2n6Jl8P0zbr17C89XYcz1DTsEzOUyOArxCaC4Q6oRR
# RuLRvWoYWmEBc8pnol7XKHYC4jMYctenIPDC+hIK12NvDMk2ZItboKaDIV1fMHSR
# lJTYuVD5C4lh8zYGNRiER9vcG9H9stQcxWv2XFJRXRLbJbqvUAV6bMURHXLvjflS
# xIUXk8A8FdsaN8cIFRg/eKtFtvUeh17aj54WcmnGrnu3tz5q4i6tAgMBAAGjggHd
# MIIB2TASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQqp1L+ZMSa
# voKRPEY1Kc8Q/y8E7jAdBgNVHQ4EFgQUn6cVXQBeYl2D9OXSZacbUzUZ6XIwXAYD
# VR0gBFUwUzBRBgwrBgEEAYI3TIN9AQEwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1Ud
# JQQMMAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1Ud
# DwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjR
# PZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0
# LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNy
# bDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9z
# b2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MA0G
# CSqGSIb3DQEBCwUAA4ICAQCdVX38Kq3hLB9nATEkW+Geckv8qW/qXBS2Pk5HZHix
# BpOXPTEztTnXwnE2P9pkbHzQdTltuw8x5MKP+2zRoZQYIu7pZmc6U03dmLq2HnjY
# Ni6cqYJWAAOwBb6J6Gngugnue99qb74py27YP0h1AdkY3m2CDPVtI1TkeFN1JFe5
# 3Z/zjj3G82jfZfakVqr3lbYoVSfQJL1AoL8ZthISEV09J+BAljis9/kpicO8F7BU
# hUKz/AyeixmJ5/ALaoHCgRlCGVJ1ijbCHcNhcy4sa3tuPywJeBTpkbKpW99Jo3QM
# vOyRgNI95ko+ZjtPu4b6MhrZlvSP9pEB9s7GdP32THJvEKt1MMU0sHrYUP4KWN1A
# PMdUbZ1jdEgssU5HLcEUBHG/ZPkkvnNtyo4JvbMBV0lUZNlz138eW0QBjloZkWsN
# n6Qo3GcZKCS6OEuabvshVGtqRRFHqfG3rsjoiV5PndLQTHa1V1QJsWkBRH58oWFs
# c/4Ku+xBZj1p/cvBQUl+fpO+y/g75LcVv7TOPqUxUYS8vwLBgqJ7Fx0ViY1w/ue1
# 0CgaiQuPNtq6TPmb/wrpNPgkNWcr4A245oyZ1uEi6vAnQj0llOZ0dFtq0Z4+7X6g
# MTN9vMvpe784cETRkPHIqzqKOghif9lwY1NNje6CbaUFEMFxBmoQtB1VM1izoXBm
# 8qGCAtcwggJAAgEBMIIBAKGB2KSB1TCB0jELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxhbmQgT3BlcmF0
# aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo4RDQxLTRCRjct
# QjNCNzElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEB
# MAcGBSsOAwIaAxUA4TyKzHwgF5U9LB4PzTmXlB16DkKggYMwgYCkfjB8MQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIFAOYGGP8wIhgP
# MjAyMjA0MTcxMjQxMzVaGA8yMDIyMDQxODEyNDEzNVowdzA9BgorBgEEAYRZCgQB
# MS8wLTAKAgUA5gYY/wIBADAKAgEAAgIAsgIB/zAHAgEAAgIRsDAKAgUA5gdqfwIB
# ADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQow
# CAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAJtGpjb23oitmj9LtvM2K6uDFZZb
# x3r/NOiFXmSTplb5Y+ZFOrNOMDCL00K2Bq36NwVBntBjEwkmFzOe9ymdNkrGO2eV
# KqZIKsuqYQURnxg3p6N49VaZkhRDGQ166oHU9SxW+Oep9MZ91rLSNgk7B4LUunT7
# V6SGp57cN8VsRzHvMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAg
# UENBIDIwMTACEzMAAAGILs3GgUHhvCoAAQAAAYgwDQYJYIZIAWUDBAIBBQCgggFK
# MBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgqgOJ
# iNtyxPupwdOKELnVz9YGWqnEQTpf0u8deNi6hFswgfoGCyqGSIb3DQEJEAIvMYHq
# MIHnMIHkMIG9BCBm6d7trAY3RoSC+M/snI7c0qXuGy1fwKGGsqZe0klApTCBmDCB
# gKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAABiC7NxoFB4bwq
# AAEAAAGIMCIEIL5oAYu6mNxsL3bXQRFj8HW4e593jBPIvKKgciD/6H6eMA0GCSqG
# SIb3DQEBCwUABIICAHArxQo495Jtf6PZ4TtziZs3EwCZswR7ATDZhMxnkVY9Tf8O
# R0eaSa8sMS8iauKaUz+OfSgnAGYp+1pcUNktIafVPErKENpzsuSnyDhI/n/u+KK3
# C+5VBFUMmTx3UsDCoKWc1oZo9/i1ALLy2er3MkrpFXIbzLdR+9w9/f12xxNqsUle
# vQrWAj1HZj//SbzvoJd5GXti3O7KmjatNOl69o+1NXFdzJnW5s+5sF9b2BqZOBLd
# 2l1AwKb5CYkiOv9K6fSOZEvLUnXueMqnU/v60+QxF6tdb7xFrzo4gNvbwYdn4EUE
# bq9QHmHMC+VZDnNV1B8ftR+eH4Ype0Wopsmth4V6SZQZsWkPFD8nhcvJ3qmqf8CW
# GWWNCbEbxQGO+ukU3/ca/dlSjqZLJycZk3DyjJSRU0yPTDYt2263tnsNqLqH24UE
# ja323Tz+V6Lza3Dx4VAlbuMMRz9XHKj7sIQSozb+9H57D1/wSYzTFLOQDNNlaKxh
# wm814A2CC9Wff5rQl4n43YMBSRRojLiIOSgeCfsXU2m11jKfuTLVMHZeLELVGBAC
# 3cZ9zIFTY63+ra6/x4w5KGeSbFwajD5pHQDMnSblqhFH/RXKg0yFJgGNgDYYWiKB
# 9hl6RjcY0+Y3rau4FuJ2W/Wx2jEC06fhzuRHLAmpJgJFXfOQPIIscdQooPx7
# SIG # End signature block
