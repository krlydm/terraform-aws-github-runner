## install the runner

Write-Host "Creating actions-runner directory for the GH Action installtion"
New-Item -ItemType Directory -Path C:\actions-runner ; Set-Location C:\actions-runner

Write-Host "Downloading the GH Action runner from s3 bucket $s3_location"
aws s3 cp ${S3_LOCATION_RUNNER_DISTRIBUTION} actions-runner.zip

