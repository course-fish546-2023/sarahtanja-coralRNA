Open RStudio terminal

Type ssh stanja@mox.hyak.uw.edu 

Input your UWNetID password

If you’re signed up for 2-factor authentication via Duo, open your smart phone and approve the connection.

You’re logged in to a Login node for Hyak!

Once logged into mox, navigate to /gscratch/scrubbed/stanja
cd /gscratch/scrubbed/stanja

Once in the scrubbed directory, use `rsync` to backup the whole dang repo
rsync -avz --progress --exclude='.*' stanja@raven.fish.washington.edu:~/sarahtanja/sarahtanja-coralRNA .

After executing the code above, you will see:
Warning: Permanently added 'raven.fish.washington.edu,172.25.149.12' (ECDSA) to the list of known hosts.
stanja@raven.fish.washington.edu's password:

Input the password for the raven server

Wait patiently for all those big files to get synced