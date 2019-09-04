---
layout: home
title:  "File Decryption/Encryption in BCDA"
date:   2019-09-04 09:21:12 -0500
description: Step-by-step instructions to assist with decrypting the NDJSON payload.
landing-page: live
gradient: "blueberry-lime-background"
subnav-link-gradient: "blueberry-lime-link"
sections:
  - How to decrypt BCDA data files
  - Troubleshooting
  - Examples in other languages
  - Background How we encrypt
---

# How to decrypt BCDA data files
We provide an example of using Python to decrypt a file from BCDA. See below for examples using other programming languages.

### 1. Gathering the tools
To complete this decryption example, you will need:

  * A client ID and client secret that you should have received during registration
  * A file containing the RSA private key corresponding with the public key you provided during registration
  
  You can write your own decryption code later based on the documentation. This example uses the python example decryption code, which requires:
  
  * Python and pip installed on your computer
  * decrypt.py and requirements.txt downloaded from the BCDA github repository into the same directory
  * You have run pip install -r requirements.txt from that same directory to download any required libraries
  
### 2. Getting ready to decrypt
This decryption example picks up at step [X] of the Getting Started in Production guide. By this point, you have provided a bearer token to the API, made a request for data, and are waiting for the export job to complete. When the job is done, you should see a response in Swagger that looks like this:

<img src="assets/img/decrypt_walkthrough_01.png" alt="job status response" width="500" />

Take special note of the new KeyMap section of the response. To decrypt the file, you will need the filename (the first part of the keymap, marked 1 in the image) and the symmetric key (the second part of the keymap, marked 2), as shown above. There are no spaces in either one. Copy these values from the KeyMap (filename and symmetric key) for later.
  
* **Note:** Sometimes one or more data points are unavailable. When this happens, the error section will contain a separate filename and symmetric key with a list of the patients involved.

The next step is to download the encrypted file.

* Open the data file section in Swagger (click /api/v1/jobs/{jobID}/{filename})
* Paste the job ID and filename into the appropriate boxes
* Click Execute
 
<img src="assets/img/decrypt_walkthrough_02.png" alt="encrypted file download" width="500" />
 
* Click the **Download file** link that appeared in the response section. Note that a large file may take a while to download.

<img src="assets/img/decrypt_walkthrough_03.png" alt="encrypted file download" width="500" />
  
### 3. Decrypting the file

After downloading the file, move to the command line. Navigate to the directory where you saved decrypt.py and requirements.txt from the Gathering the tools section.

<img src="assets/img/decrypt_walkthrough_04.png" alt="decryption with python" width="500" />

Let’s first verify that Python is running properly.

* Run decrypt.py with the help argument (python decrypt.py -h). You should get the response shown below.

<img src="assets/img/decrypt_walkthrough_05.png" alt="decryption with python" width="500" />

* Rename the downloaded file with the filename you saved earlier. **This is extremely important as the file name is used as part of the file decryption process and using a different file name will cause decryption to fail.**

**Note: At present, you must have the NDJSON file saved to the same folder as the decryption utilities in order to successfully decrypt.**

<img src="assets/img/decrypt_walkthrough_06.png" alt="decryption with python" width="500" />

You are now ready to decrypt the file! The Python example decryption tool will print the decrypted contents to the console, so you can send the output to a file. Make sure to use the following syntax, with the entire command on the same line:

    python decrypt.py 
        --pk   [location_of_private_key] 
        --file [location_of_encrypted_file] 
        --key  [symmetric_key_value]
        > filename.txt

<img src="assets/img/decrypt_walkthrough_07.png" alt="decryption with python" width="500" />

Take a look at the result. If you do not see unencrypted NDJSON (two example lines shown below), then skip ahead to the troubleshooting section.

<img src="assets/img/decrypt_walkthrough_08.png" alt="decryption with python" width="500" />

## Troubleshooting

#### Authentication problems in Swagger
* Did you use Basic authorization to present the credentials (Client ID and Client Secret) you received separately from BCDA?
* After entering your credentials, did you get an access token from `/auth/token?`
* Did you put your access token in the `bearer_token` section of the authorization dialog, preceded by the word “Bearer “? (The capital B in “Bearer” is important.)
* Has your token expired? Use your credentials to get a new token from `/auth/token`.
* Is it possible you clicked on `Logout`? Is the lock on the `Authorize` icon not closed? Click it again, and after pasting your token in the `bearer_token` box, make sure to click the `Authorize` button.
* Are there any spaces or newlines in your token? Remove them and paste it as a single line.
* Do you get an HTTP 504 `GATEWAY_TIMEOUT` error? Make sure to add the word “Bearer” (and a space) before the token.

#### Python not installed
* Is this your first time running Python on your system? You might be interested in this [Windows installation guide](https://www.howtogeek.com/197947/how-to-install-python-on-windows/){:target="_blank"}

### Encryption issues
* Are you having  trouble with the private key? The best practice would be to keep your private key in a separate, secured directory. While you’re testing the encryption feature for the first time, however, you may find it useful to have all the files in the same directory.
* Have you saved the encrypted file with exactly the filename provided by the API? If not, rename it and try again.
* Is the symmetric key value provided with no spaces or newlines? Double-check that no characters are missing from the beginning or end of the key.

## Examples in other languages
These code samples are based on the filenames and symmetric keys included in the sample job status response above. If you are interested in sample code in other languages, please let us know via the Google Group.

[C#](https://github.com/CMSgov/bcda-app/tree/master/encryption_utils/C%23){:target="_blank"}
```bash
dotnet run decrypt.cs \
	--file /path/to/0c527d2e-2e8a-4808-b11d-0fa06baf8254.ndjson \
	--pk /path/to/bcda-app/shared_files/ATO_private.pem \
	--key 6c498a997001592ac05ace691fcf4a81724936c78937e24f90242c4f3081759f5365bef70a79eb0a6e145d22190b1178acf9f819399d27a4261efedf027642ca37d3f50cc0b941b105e35fc5b21cc785b171acb0ed299be16ff86fb457ff00d6855fefc9d403efdecbaca81ebffc85f8dbf1574d791640d392c5523482578ed232f7554880fa52d3471a4d919ab1ae8687e0442697cad7326aeb6ad0ddecaaeccaf61f952ef0cde2a3f15167b8854f8620440d8f1d9e09a0a39f1d04a3acf8178e5b6b28d9a062f09ff5fece3d16d9aacf7d43f4b94932d4f3268d1029f2874f3542ba71c858586393a80f45cb92b0cff9d2857b960045d733183d15c3599377 \
	> decrypted_output.ndjson
```

[Golang](https://github.com/CMSgov/bcda-app/blob/master/decryption_utils/Go/decrypt.go){:target="_blank"}
```bash

go build decrypt.go
./decrypt \
	--file /path/to/0c527d2e-2e8a-4808-b11d-0fa06baf8254.ndjson \
	--pk /path/to/bcda-app/shared_files/ATO_private.pem \
	--key 6c498a997001592ac05ace691fcf4a81724936c78937e24f90242c4f3081759f5365bef70a79eb0a6e145d22190b1178acf9f819399d27a4261efedf027642ca37d3f50cc0b941b105e35fc5b21cc785b171acb0ed299be16ff86fb457ff00d6855fefc9d403efdecbaca81ebffc85f8dbf1574d791640d392c5523482578ed232f7554880fa52d3471a4d919ab1ae8687e0442697cad7326aeb6ad0ddecaaeccaf61f952ef0cde2a3f15167b8854f8620440d8f1d9e09a0a39f1d04a3acf8178e5b6b28d9a062f09ff5fece3d16d9aacf7d43f4b94932d4f3268d1029f2874f3542ba71c858586393a80f45cb92b0cff9d2857b960045d733183d15c3599377 \
	> decrypted_output.ndjson
```

## Background How we encrypt
We encrypt the file as the last step in producing it, immediately before we return a final job status (the one that has a body and no X-Progress header). Please see our getting started guide for more on job status.

The steps in our encryption process are:

1. Generate a random 32 byte / 256 bit symmetric encryption key.
2. Generate a random nonce (also known as an Initialization Value, or IV).
3. Read the data from the file.
4. We use the nonce and encryption key to encrypt the data with the AES-GCM algorithm. We do not append additional data. The resulting cipher text output begins with a byte indicating the size of the nonce, the nonce itself, then the encrypted data, and finally the additional data.
5. Encrypt the symmetric key using the RSA public key you provided us. We use the filename as the label.
6. Write the encrypted file to the appropriate data directory.
7. Return the encrypted keys as hex-encoded strings in the body of the final job status method, along with file download urls and other information. There can be two files, a data file and an error file. Each file will be encrypted with a different symmetric key. An example body follows:
