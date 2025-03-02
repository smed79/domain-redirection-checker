## Domain Redirection Checker

A Bash script to check the final redirection of domains from a list of URLs. The script reads URLs from a file, follows their redirections, and outputs the final domain names. If interrupted, the script can resume from the last processed URL.

### Requirements

- `curl` command-line tool.

### Usage

1. **Prepare the URLs list:**

   Create a file named `domains.txt` with one domain/URL per line.
   
   If the file does not exist, you will be prompted to provide the path to another file.

3. **Run the script:**

   ```bash
   chmod +x redirect_checker.sh
   ./redirect_checker.sh
   ```

   Note: _The maximum timeout for the `curl` command is set to 5 seconds by default. You can change this value by modifying the script (look for the `--max-time` option in the `curl` command)_.

4. **View the results:**

   Results will be displayed in the terminal and saved to `output.txt` in the format:

   ```plaintext
   original_url => final_domain_name
   ```

#### Example Output

   ```bash
   google.com => www.google.com
   facebook.com => www.facebook.com
   amazon.com => www.amazon.com
   twitter.com => twitter.com
   wikipedia.org => www.wikipedia.org
   youtube.com => www.youtube.com
   linkedin.com => www.linkedin.com
   instagram.com => www.instagram.com
   reddit.com => www.reddit.com
   netflix.com => netflix.com
   microsoft.com => www.microsoft.com
   apple.com => www.apple.com
   ```

#### Support this Project

Star ★ this repo, and we're square :nerd_face:

### License

This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported.

See [LICENSE](https://creativecommons.org/licenses/by-nc-sa/3.0/) for details. 
